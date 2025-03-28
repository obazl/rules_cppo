def _cppo_impl(name, visibility,
               srcs,
               defines,
               vars,
               **kwargs):
    """Runs 'cppo'. """
    deflist = []

    for d in defines:
        deflist.append("-D " + d)

    vlist = []
    for k,v in vars.items():
        if v == "VERSION":
            param = "5.3.0"
        vlist.append("-V " + k + ":" + param)

    outs = []
    for src in srcs:
        outs.append(src.name + ".cppo")

    native.genrule(
        name    = name,
        srcs  = srcs,
        outs  = outs,
        tools = ["@opam.cppo//bin:cppo"],
        cmd = " ".join([
            "$(location @opam.cppo//bin:cppo)",
            "{}".format(" ".join(deflist)),
            "{}".format(" ".join(vlist)),
            "$< > $@"
        ]),
        visibility = visibility
)

######################
cppo = macro(
    doc = """
    """,
    implementation = _cppo_impl,
    inherit_attrs = native.genrule,
    attrs = {
        "srcs": attr.label_list(
            doc = "List of files",
            configurable = False
        ),
        # "srcs": None,
        # "out": attr.label(
        #     doc = "Label of output file",
        #     # configurable = False
        # ),
        "outs": None,

        "defines": attr.string_list(
            doc = "List of -D defines",
            configurable = False
        ),
        "vars": attr.string_dict(
            doc = "test",
            configurable = False
        )
    }
)
