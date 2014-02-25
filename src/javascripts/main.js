
$(function() {
  $("h1").i18n();
})

// A recommended setup for i18next
i18n.init({
  resStore: preloadedLocales,
  selectorAttr: "i18n",
  debug: true
})