{{- /* Helper to add a default * entries for rules that do not define apiGroups/resources/verbs and render them as yaml */}}
{{- define "vp-rbac.rulesHelper" -}}
{{- $rules := index . 0 -}}
{{- /* If rules is empty/nil or has no entries, provide a default rule with all permissions */}}
{{- if or (not $rules) (eq (len $rules) 0) -}}
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
{{- else -}}
{{- /* Process each rule and provide defaults for missing fields */}}
{{- range $index, $rule := $rules -}}
- {{- if not (hasKey $rule "apiGroups") }}
  apiGroups: ["*"]
  {{- else }}
  apiGroups:
{{- $rule.apiGroups | toYaml | nindent 4 }}
  {{- end }}
  {{- if not (hasKey $rule "resources") }}
  resources: ["*"]
  {{- else }}
  resources:
{{- $rule.resources | toYaml | nindent 4 }}
  {{- end }}
  {{- if not (hasKey $rule "verbs") }}
  verbs: ["*"]
  {{- else }}
  verbs:
{{- $rule.verbs | toYaml | nindent 4 }}
  {{- end -}}
  {{- if hasKey $rule "resourceNames" }}
  resourceNames:
{{- $rule.resourceNames | toYaml | nindent 4 }}
  {{- end -}}
  {{- if hasKey $rule "nonResourceURLs" }}
  nonResourceURLs:
{{- $rule.nonResourceURLs | toYaml | nindent 4 }}
  {{- end }}
{{- end }} {{/* end range $rules */}}
{{- end }} {{/* end if rules check */}}
{{- end -}} {{/* end define */}}
