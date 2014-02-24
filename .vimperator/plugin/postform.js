
// Nuances gleaned from browser.jar/content/browser/browser.js
function parseForm(submit)
{
    function encode(name, value)
    {
        if (post)
            return encodeURIComponent(name + "=" + value);
        return encodeURIComponent(name) + "=" + encodeURIComponent(value);
    }

    let form = submit.form;
    let doc = form.ownerDocument;
    let charset = doc.charset;
    let uri = window.makeURI(doc.URL, charset);
    let url = window.makeURI(form.getAttribute("action"), charset, uri).spec;

    let post = form.method.toUpperCase() == "POST"
            && (form.enctype == "application/x-www-form-urlencoded" || form.enctype == "");

    let elems = [encode(submit.name, submit.value)];
    for (let [,elem] in Iterator(form.elements)) {
        if (/^(?:text|hidden|textarea)$/.test(elem.type) || elem.checked && /^(?:checkbox|radio)$/.test(elem.type))
        {
            elems.push(encode(elem.name, elem.value));
        }
        else if (elem instanceof HTMLSelectElement)
        {
            for (let [,opt] in Iterator(elem.options))
            {
                if (opt.selected)
                    elems.push(encode(elem.name, opt.value));
            }
        }
    }
    let data = elems.join("&");
    if (post)
        return [url, data];
    return [url + "?" + data, null];
}

function listener(event)
{
    let elem = event.target;
    if (!(elem instanceof HTMLInputElement) || elem.type != "submit")
        return;
    if (elem.ownerDocument.defaultView.top != content)
        return;
    if (event.button != 1)
        return;

    liberator.open([parseForm(elem)], liberator.NEW_TAB);
}

function onUnload()
{
    appContent.removeEventListener("click", listener, true);
}
appContent.addEventListener("click", listener, true);

