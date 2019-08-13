Example:

    aws-rotate completion

Prints words for TAB auto-completion.

Examples:

    aws-rotate completion
    aws-rotate completion hello
    aws-rotate completion hello name

To enable, TAB auto-completion add the following to your profile:

    eval $(aws-rotate completion_script)

Auto-completion example usage:

    aws-rotate [TAB]
    aws-rotate hello [TAB]
    aws-rotate hello name [TAB]
    aws-rotate hello name --[TAB]
