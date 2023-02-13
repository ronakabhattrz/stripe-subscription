const { environment } = require('@rails/webpacker')

const webpack = require("webpack")

environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: "jQuery",
    jQuery: "jQuery",
    Popper: ["popper.js", "default"]
}))

module.exports = environment