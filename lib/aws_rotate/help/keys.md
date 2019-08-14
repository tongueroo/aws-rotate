## Examples

    aws-rotate keys
    AWS_PROFILE=my-profile aws-rotate keys

## Select Filter Option

    aws-rotate keys --select dev-
    aws-rotate keys -s dev- # shorthand
    aws-rotate keys -s ^dev- ^test- # multiple patterns

## Reject Filter Option

    aws-rotate keys --reject prod-
    aws-rotate keys -r prod- # shorthand
    aws-rotate keys -r ^prod- ^production- # multiple patterns