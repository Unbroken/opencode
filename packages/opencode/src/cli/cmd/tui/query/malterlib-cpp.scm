; Malterlib naming overlay for tree-sitter-cpp

; Keep the stock cpp query first, then refine identifier classes here.

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#match? @malterlib.type "^CFWStr[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#match? @malterlib.type "^CFUStr[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function.template.template.param.pack
  (#match? @malterlib.function.template.template.param.pack "^tfp_TC[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function.template.template.param.pack
  (#match? @malterlib.function.template.template.param.pack "^tfp_TF[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#match? @malterlib.type "^CFStr[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.variable.private.functor
  (#match? @malterlib.member.static.variable.private.functor "^msp_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.function.private.recursive
  (#match? @malterlib.member.static.function.private.recursive "^fspr_[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.function.private.recursive
  (#match? @malterlib.member.static.function.private.recursive "^fsp_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.static.function.recursive
  (#match? @malterlib.static.function.recursive "^fsgr_[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.static.function.recursive
  (#match? @malterlib.static.function.recursive "^fsg_r[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function.template.type.param.class.pack
  (#match? @malterlib.function.template.type.param.class.pack "^tfp_C[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function.template.type.param.function.pack
  (#match? @malterlib.function.template.type.param.function.pack "^tfp_F[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function.template.template.param
  (#match? @malterlib.function.template.template.param "^tf_TC[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function.template.template.param
  (#match? @malterlib.function.template.template.param "^tf_TF[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.template.param.pack
  (#match? @malterlib.template.template.param.pack "^tp_TC[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.template.param.pack
  (#match? @malterlib.template.template.param.pack "^tp_TF[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.variable.private
  (#match? @malterlib.member.static.variable.private "^msp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.member.static.variable.private "^msp_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.constant.private
  (#match? @malterlib.member.constant.private "^mcp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.variable.public.functor
  (#match? @malterlib.member.static.variable.public.functor "^ms_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.variable.private.functor
  (#match? @malterlib.member.variable.private.functor "^mp_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.global.static.variable.functor
  (#match? @malterlib.global.static.variable.functor "^gs_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.function.private
  (#match? @malterlib.member.static.function.private "^fsp_[A-Z0-9].*$")
  (#not-match? @malterlib.member.static.function.private "^fsp_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.static.function
  (#match? @malterlib.static.function "^fsg_[A-Z0-9].*$")
  (#not-match? @malterlib.static.function "^fsg_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.function.public.recursive
  (#match? @malterlib.member.static.function.public.recursive "^fsr_[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.function.public.recursive
  (#match? @malterlib.member.static.function.public.recursive "^fs_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.function.private.recursive
  (#match? @malterlib.member.function.private.recursive "^fpr_[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.function.private.recursive
  (#match? @malterlib.member.function.private.recursive "^fp_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.recursive
  (#match? @malterlib.function.recursive "^fgr_[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.recursive
  (#match? @malterlib.function.recursive "^fg_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.output.pack.functor
  (#match? @malterlib.function.parameter.output.pack.functor "^po_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.output.pack.functor
  (#match? @malterlib.function.parameter.output.pack.functor "^p_of[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.template.non.type.param.pack
  (#match? @malterlib.function.template.non.type.param.pack "^tfp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.template.non.type.param.pack "^tfp_TC[A-Z0-9].*$")
  (#not-match? @malterlib.function.template.non.type.param.pack "^tfp_TF[A-Z0-9].*$")
  (#not-match? @malterlib.function.template.non.type.param.pack "^tfp_C[A-Z0-9].*$")
  (#not-match? @malterlib.function.template.non.type.param.pack "^tfp_F[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function.template.type.param.class
  (#match? @malterlib.function.template.type.param.class "^tf_C[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function.template.type.param.function
  (#match? @malterlib.function.template.type.param.function "^tf_F[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type.param.class.pack
  (#match? @malterlib.template.type.param.class.pack "^tp_C[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type.param.function.pack
  (#match? @malterlib.template.type.param.function.pack "^tp_F[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.template.param
  (#match? @malterlib.template.template.param "^t_TC[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.template.param
  (#match? @malterlib.template.template.param "^t_TF[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.variable.public
  (#match? @malterlib.member.static.variable.public "^ms_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.member.static.variable.public "^ms_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.variable.private
  (#match? @malterlib.member.variable.private "^mp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.member.variable.private "^mp_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.constant.public
  (#match? @malterlib.member.constant.public "^mc_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.variable.public.functor
  (#match? @malterlib.member.variable.public.functor "^m_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.global.static.variable
  (#match? @malterlib.global.static.variable "^gs_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.global.static.variable "^gs_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.global.constant
  (#match? @malterlib.global.constant "^gc_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.global.variable.functor
  (#match? @malterlib.global.variable.functor "^g_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.static.function.public
  (#match? @malterlib.member.static.function.public "^fs_[A-Z0-9].*$")
  (#not-match? @malterlib.member.static.function.public "^fs_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.function.private
  (#match? @malterlib.member.function.private "^fp_[A-Z0-9].*$")
  (#not-match? @malterlib.member.function.private "^fp_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function
  (#match? @malterlib.function "^fg_[A-Z0-9].*$")
  (#not-match? @malterlib.function "^fg_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.function.public.recursive
  (#match? @malterlib.member.function.public.recursive "^fr_[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.function.public.recursive
  (#match? @malterlib.member.function.public.recursive "^f_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.variable.functor
  (#match? @malterlib.variable.functor "^fl_[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.output.pack
  (#match? @malterlib.function.parameter.output.pack "^po_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.parameter.output.pack "^po_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.output.pack
  (#match? @malterlib.function.parameter.output.pack "^p_o(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.parameter.output.pack "^p_of[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.pack.functor
  (#match? @malterlib.function.parameter.pack.functor "^p_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.output.functor
  (#match? @malterlib.function.parameter.output.functor "^o_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.output.functor
  (#match? @malterlib.function.parameter.output.functor "^_of[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.template.non.type.param
  (#match? @malterlib.function.template.non.type.param "^tf_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.template.non.type.param "^tf_TC[A-Z0-9].*$")
  (#not-match? @malterlib.function.template.non.type.param "^tf_TF[A-Z0-9].*$")
  (#not-match? @malterlib.function.template.non.type.param "^tf_C[A-Z0-9].*$")
  (#not-match? @malterlib.function.template.non.type.param "^tf_F[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.template.non.type.param.pack
  (#match? @malterlib.template.non.type.param.pack "^tp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.template.non.type.param.pack "^tp_TC[A-Z0-9].*$")
  (#not-match? @malterlib.template.non.type.param.pack "^tp_TF[A-Z0-9].*$")
  (#not-match? @malterlib.template.non.type.param.pack "^tp_C[A-Z0-9].*$")
  (#not-match? @malterlib.template.non.type.param.pack "^tp_F[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type.param.class
  (#match? @malterlib.template.type.param.class "^t_C[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type.param.function
  (#match? @malterlib.template.type.param.function "^t_F[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type.interface
  (#match? @malterlib.template.type.interface "^TIC[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.static.variable.functor
  (#match? @malterlib.static.variable.functor "^s_f[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#match? @malterlib.type "^CF(?:Str|UStr|WStr)$")
  (#not-match? @malterlib.type "^CFWStr[A-Z0-9].*$")
  (#not-match? @malterlib.type "^CFUStr[A-Z0-9].*$")
  (#not-match? @malterlib.type "^CFStr[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#match? @malterlib.type "^CF[A-Z0-9].*Ref$")
  (#not-match? @malterlib.type "^CFWStr[A-Z0-9].*$")
  (#not-match? @malterlib.type "^CFUStr[A-Z0-9].*$")
  (#not-match? @malterlib.type "^CFStr[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.variable.public
  (#match? @malterlib.member.variable.public "^m_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.member.variable.public "^m_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.global.variable
  (#match? @malterlib.global.variable "^g_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.global.variable "^g_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.member.function.public
  (#match? @malterlib.member.function.public "^f_[A-Z0-9].*$")
  (#not-match? @malterlib.member.function.public "^f_r[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.pack
  (#match? @malterlib.function.parameter.pack "^p_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.parameter.pack "^p_of[A-Z0-9].*$")
  (#not-match? @malterlib.function.parameter.pack "^p_o(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.parameter.pack "^p_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.output
  (#match? @malterlib.function.parameter.output "^o_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.parameter.output "^o_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.output
  (#match? @malterlib.function.parameter.output "^_o(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.parameter.output "^_of[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter.functor
  (#match? @malterlib.function.parameter.functor "^_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.template.non.type.param
  (#match? @malterlib.template.non.type.param "^t_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.template.non.type.param "^t_TC[A-Z0-9].*$")
  (#not-match? @malterlib.template.non.type.param "^t_TF[A-Z0-9].*$")
  (#not-match? @malterlib.template.non.type.param "^t_C[A-Z0-9].*$")
  (#not-match? @malterlib.template.non.type.param "^t_F[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#match? @malterlib.template.type "^TF[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#match? @malterlib.template.type "^TC[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#match? @malterlib.type "^UI[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#match? @malterlib.type "^NS[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type.interface
  (#match? @malterlib.type.interface "^IC[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function
  (#match? @malterlib.function "^CF[A-Z0-9].*$")
  (#not-match? @malterlib.function "^CFWStr[A-Z0-9].*$")
  (#not-match? @malterlib.function "^CFUStr[A-Z0-9].*$")
  (#not-match? @malterlib.function "^CFStr[A-Z0-9].*$")
  (#not-match? @malterlib.function "^CF[A-Z0-9].*Ref$")
  (#not-match? @malterlib.function "^CF(?:Str|UStr|WStr)$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.constant.variable
  (#match? @malterlib.constant.variable "^c_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.macro.parameter
  (#match? @malterlib.macro.parameter "^d_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.static.variable
  (#match? @malterlib.static.variable "^s_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.static.variable "^s_f[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.function.parameter
  (#match? @malterlib.function.parameter "^_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.parameter "^_of[A-Z0-9].*$")
  (#not-match? @malterlib.function.parameter "^_o(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.function.parameter "^_f[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#match? @malterlib.type "^C[A-Z0-9].*$")
  (#not-match? @malterlib.type "^CF(?:Str|UStr|WStr)$")
  (#not-match? @malterlib.type "^CF[A-Z0-9].*Ref$")
  (#not-match? @malterlib.type "^CFWStr[A-Z0-9].*$")
  (#not-match? @malterlib.type "^CFUStr[A-Z0-9].*$")
  (#not-match? @malterlib.type "^CFStr[A-Z0-9].*$")
  (#not-match? @malterlib.type "^CF[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.macro
  (#match? @malterlib.macro "^D[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.namespace
  (#match? @malterlib.namespace "^N[A-Z0-9].*$")
  (#not-match? @malterlib.namespace "^NS[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type.function
  (#match? @malterlib.type.function "^F[A-Z0-9].*$")
)

([
  (identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.enum
  (#match? @malterlib.enum "^E[A-Z0-9][^_]*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.enumerator
  (#match? @malterlib.enumerator "^E[A-Z0-9].*_.*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.enumerator
  (#match? @malterlib.enumerator "^k[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.concept
  (#match? @malterlib.concept "^c[A-Z0-9].*$")
  (#not-match? @malterlib.concept "^c_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.variable.functor
  (#match? @malterlib.variable.functor "^f[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fspr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fsp_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fsp_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fsgr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fsg_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fsg_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fsr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fs_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fs_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fpr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fp_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fp_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fgr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fg_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fg_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^f_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^f_[A-Z0-9].*$")
  (#not-match? @malterlib.variable.functor "^fl_[A-Z0-9].*$")
)

([
  (identifier)
  (field_identifier)
] @malterlib.variable
  (#match? @malterlib.variable "^(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^CF(?:Str|UStr|WStr)$")
  (#not-match? @malterlib.variable "^CF[A-Z0-9].*Ref$")
  (#not-match? @malterlib.variable "^CFWStr[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^CFUStr[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^CFStr[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^msp_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^msp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^mcp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^ms_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^ms_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^mp_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^mp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^mc_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^m_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^m_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^gs_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^gs_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^gc_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^g_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^g_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^fspr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fsp_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fsp_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fsgr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fsg_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fsg_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fsr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fs_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fs_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fpr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fp_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fp_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fgr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fg_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fg_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fr_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^f_r[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^f_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^fl_[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^po_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^po_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^p_of[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^p_o(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^p_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^p_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^o_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^o_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^_of[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^_o(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^tfp_TC[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tfp_TF[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tfp_C[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tfp_F[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tfp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^tf_TC[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tf_TF[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tf_C[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tf_F[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tf_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^tp_TC[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tp_TF[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tp_C[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tp_F[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^tp_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^t_TC[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^t_TF[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^t_C[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^t_F[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^t_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^TIC[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^TF[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^TC[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^UI[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^NS[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^IC[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^CF[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^C[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^D[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^N[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^F[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^E[A-Z0-9][^_]*$")
  (#not-match? @malterlib.variable "^E[A-Z0-9].*_.*$")
  (#not-match? @malterlib.variable "^k[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^c_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^c[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^d_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^s_f[A-Z0-9].*$")
  (#not-match? @malterlib.variable "^s_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
  (#not-match? @malterlib.variable "^f[A-Z0-9].*$")
)

; Recolor reference punctuation that upstream parameter captures mark as parameter text.

(reference_declarator
  [
    "&"
    "&&"
  ] @malterlib.operator.reference)

(abstract_reference_declarator
  [
    "&"
    "&&"
  ] @malterlib.operator.reference)

; Best-effort preprocessor body matches for bare macro parameters.

(preproc_function_def
  value: (preproc_arg) @malterlib.macro.parameter
  (#match? @malterlib.macro.parameter "^(?:\\\r?\n[ \t]*)?d_(?:[A-Z0-9]|[binpfro][A-Z0-9]).*$")
)

; Static exact-name overrides from the Malterlib identifier table.

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.enum
  (#eq? @malterlib.enum "memory_order")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.enumerator
  (#eq? @malterlib.enumerator "memory_order_acq_rel")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.enumerator
  (#eq? @malterlib.enumerator "memory_order_acquire")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.enumerator
  (#eq? @malterlib.enumerator "memory_order_consume")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.enumerator
  (#eq? @malterlib.enumerator "memory_order_relaxed")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.enumerator
  (#eq? @malterlib.enumerator "memory_order_release")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.enumerator
  (#eq? @malterlib.enumerator "memory_order_seq_cst")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "allocate_shared")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "bind")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "const_pointer_cast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "declval")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "dynamic_pointer_cast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "forward")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "forward_as_tuple")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "get_deleter")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "getline")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "make_pair")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "make_shared")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "make_tuple")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "max")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "min")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "move")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "move_if_noexcept")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "static_pointer_cast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "tie")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.function
  (#eq? @malterlib.function "tuple_cat")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.access
  (#eq? @malterlib.keyword.access "friend")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.access
  (#eq? @malterlib.keyword.access "private")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.access
  (#eq? @malterlib.keyword.access "protected")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.access
  (#eq? @malterlib.keyword.access "public")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.auto
  (#eq? @malterlib.keyword.auto "auto")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "__wchar_t")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "ch16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "ch32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "ch8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "char")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "char16_t")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "char32_t")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "uch16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "uch32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "uch8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "wchar_t")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "zch16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "zch32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "zch8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "zuch16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "zuch32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.character.types
  (#eq? @malterlib.keyword.builtin.character.types "zuch8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.constants
  (#eq? @malterlib.keyword.builtin.constants "NULL")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.constants
  (#eq? @malterlib.keyword.builtin.constants "false")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.constants
  (#eq? @malterlib.keyword.builtin.constants "nullptr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.constants
  (#eq? @malterlib.keyword.builtin.constants "true")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "double")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "float")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp1024")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp2048")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp256")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp4096")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp512")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "fp80")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp1024")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp2048")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp256")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp4096")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp512")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "ufp80")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp1024")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp2048")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp256")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp4096")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp512")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zfp80")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp1024")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp2048")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp256")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp4096")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp512")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.float.types
  (#eq? @malterlib.keyword.builtin.float.types "zufp80")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "__int16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "__int32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "__int64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "__int8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "aint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int1024")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int160")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int2048")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int256")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int4096")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int512")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int80")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "int8192")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "mint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "size_t")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "smint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uaint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint1024")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint160")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint2048")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint256")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint4096")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint512")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint80")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "uint8192")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "umint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zamint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint1024")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint160")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint2048")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint256")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint4096")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint512")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint80")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zint8192")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zmint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zsmint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuamint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint1024")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint160")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint2048")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint256")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint4096")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint512")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint80")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zuint8192")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.integer.types
  (#eq? @malterlib.keyword.builtin.integer.types "zumint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.type.modifiers
  (#eq? @malterlib.keyword.builtin.type.modifiers "long")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.type.modifiers
  (#eq? @malterlib.keyword.builtin.type.modifiers "short")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.type.modifiers
  (#eq? @malterlib.keyword.builtin.type.modifiers "signed")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.type.modifiers
  (#eq? @malterlib.keyword.builtin.type.modifiers "unsigned")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.types
  (#eq? @malterlib.keyword.builtin.types "bint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.types
  (#eq? @malterlib.keyword.builtin.types "bool")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.types
  (#eq? @malterlib.keyword.builtin.types "void")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.types
  (#eq? @malterlib.keyword.builtin.types "zbint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.types
  (#eq? @malterlib.keyword.builtin.types "zbool")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.vector.types
  (#eq? @malterlib.keyword.builtin.vector.types "__m128")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.vector.types
  (#eq? @malterlib.keyword.builtin.vector.types "__m128d")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.vector.types
  (#eq? @malterlib.keyword.builtin.vector.types "__m128i")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.vector.types
  (#eq? @malterlib.keyword.builtin.vector.types "__m64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.builtin.vector.types
  (#eq? @malterlib.keyword.builtin.vector.types "__w64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.casts
  (#eq? @malterlib.keyword.casts "const_cast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.casts
  (#eq? @malterlib.keyword.casts "dynamic_cast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.casts
  (#eq? @malterlib.keyword.casts "reinterpret_cast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.casts
  (#eq? @malterlib.keyword.casts "static_cast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__abstract")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__box")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__delegate")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__gc")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__hook")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__identifier")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__nogc")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__pin")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__property")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__sealed")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__try_cast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__unhook")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "__value")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "abstract")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "array")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "delegate")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "event")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "friend_as")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "gcnew")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "generic")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "initonly")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "interface")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "interior_ptr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "literal")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "ref")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "safecast")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.clr
  (#eq? @malterlib.keyword.clr "value")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "assume")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "break")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "case")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "constant_int64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "constant_uint64")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "continue")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "default")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "do")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "else")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "for")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "goto")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "if")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "likely")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "return")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "switch")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "unlikely")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "while")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.control.statement
  (#eq? @malterlib.keyword.control.statement "yield_cpu")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "__except")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "__finally")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "__leave")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "__raise")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "__try")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "catch")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "finally")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "throw")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.exception.handling
  (#eq? @malterlib.keyword.exception.handling "try")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.introspection
  (#eq? @malterlib.keyword.introspection "__alignof")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.introspection
  (#eq? @malterlib.keyword.introspection "__uuidof")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.introspection
  (#eq? @malterlib.keyword.introspection "decltype")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.introspection
  (#eq? @malterlib.keyword.introspection "sizeof")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.introspection
  (#eq? @malterlib.keyword.introspection "typeid")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.namespace
  (#eq? @malterlib.keyword.namespace "namespace")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.new.delete
  (#eq? @malterlib.keyword.new.delete "delete")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.new.delete
  (#eq? @malterlib.keyword.new.delete "new")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.operator
  (#eq? @malterlib.keyword.operator "operator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.optimization
  (#eq? @malterlib.keyword.optimization "__asm")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.optimization
  (#eq? @malterlib.keyword.optimization "__assume")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__event")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__if_exists")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__if_not_exists")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__interface")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__multiple_inheritance")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__noop")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__single_inheritance")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__super")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.other
  (#eq? @malterlib.keyword.other "__virtual_inheritance")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__attribute__")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__based")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__cdecl")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__declspec")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__fastcall")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__forceinline")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__inline")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__pragma")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__restrict__")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__stdcall")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__thiscall")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "__unaligned")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "align_cacheline")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "assure_used")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "calling_convention_c")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "carries_dependency")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "cdecl")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "constexpr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "deprecated")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "dllexport")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "dllimport")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "explicit")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "fallthrough")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "fastcall")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "function_does_not_return")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "ignore")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_always")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_always_debug")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_always_lambda")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_extralarge")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_large")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_medium")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_never")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_never_debug")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "inline_small")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "intrinsic")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "mark_artificial")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "mark_no_coroutine_debug")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "mark_nodebug")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "maybe_unused")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "module_export")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "module_import")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "naked")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "no_unique_address")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "nodiscard")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "noexcept")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "noinline")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "noreturn")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "nothrow")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "novtable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "only_parameters_aliased")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "optimize_for_synchronized")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "property")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "return_not_aliased")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "selectany")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "stdcall")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "str_utf16")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "str_utf32")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "str_utf8")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "thread")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "uuid")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.property.modifiers
  (#eq? @malterlib.keyword.property.modifiers "variable_not_aliased")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.pure
  (#eq? @malterlib.keyword.pure "pure")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.qualifier
  (#eq? @malterlib.keyword.qualifier "const")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.qualifier
  (#eq? @malterlib.keyword.qualifier "volatile")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.static.assert
  (#eq? @malterlib.keyword.static.assert "static_assert")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.storage.class
  (#eq? @malterlib.keyword.storage.class "extern")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.storage.class
  (#eq? @malterlib.keyword.storage.class "mutable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.storage.class
  (#eq? @malterlib.keyword.storage.class "register")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.storage.class
  (#eq? @malterlib.keyword.storage.class "static")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.template
  (#eq? @malterlib.keyword.template "template")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.this
  (#eq? @malterlib.keyword.this "this")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.type.specification
  (#eq? @malterlib.keyword.type.specification "class")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.type.specification
  (#eq? @malterlib.keyword.type.specification "enum")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.type.specification
  (#eq? @malterlib.keyword.type.specification "struct")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.type.specification
  (#eq? @malterlib.keyword.type.specification "union")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.typedef
  (#eq? @malterlib.keyword.typedef "typedef")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.typename
  (#eq? @malterlib.keyword.typename "typename")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.using
  (#eq? @malterlib.keyword.using "using")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.virtual
  (#eq? @malterlib.keyword.virtual "final")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.virtual
  (#eq? @malterlib.keyword.virtual "override")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.virtual
  (#eq? @malterlib.keyword.virtual "sealed")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.keyword.virtual
  (#eq? @malterlib.keyword.virtual "virtual")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.macro
  (#eq? @malterlib.macro "assert")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.constant.public
  (#eq? @malterlib.member.constant.public "npos")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "assign")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "at")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "back")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "before_begin")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "bucket")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "bucket_count")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "bucket_size")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "c_str")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "capacity")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "cbefore_begin")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "clear")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "compare")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "compare_exchange_strong")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "compare_exchange_weak")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "copy")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "count")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "data")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "emplace")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "emplace_after")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "emplace_back")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "emplace_front")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "emplace_hint")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "empty")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "equal_range")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "erase")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "erase_after")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "exchange")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "fetch_add")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "fetch_and")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "fetch_or")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "fetch_sub")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "fetch_xor")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "fill")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "find")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "find_first_not_of")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "find_first_of")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "find_last_of")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "fint_last_not_of")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "front")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "get_allocator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "hash_fuction")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "insert")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "insert_after")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "is_lock_free")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "key_comp")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "key_eq")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "length")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "load")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "load_factor")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "lower_bound")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "max_bucket_count")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "max_load_factor")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "max_size")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "merge")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "pop")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "pop_back")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "pop_front")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "push")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "push_back")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "push_front")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "rehash")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "remove")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "remove_if")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "reserve")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "resize")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "reverse")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "rfind")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "shrink_to_fit")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "size")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "sort")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "splice")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "splice_after")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "store")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "substr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "top")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "unique")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "upper_bound")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.member.function.public
  (#eq? @malterlib.member.function.public "value_comp")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.namespace
  (#eq? @malterlib.namespace "std")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "define")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "defined")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "elif")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "endif")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "error")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "ifdef")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "ifndef")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "import")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "include")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "line")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "once")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "pragma")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.preprocessor.directive
  (#eq? @malterlib.preprocessor.directive "undef")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "add_const")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "add_cv")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "add_lvalue_reference")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "add_pointer")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "add_rvalue_reference")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "add_volatile")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "aligned_storage")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "aligned_union")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "alignment_of")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "allocator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "atomic")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "auto_ptr_ref")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "basic_filebuf")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "basic_fstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "basic_ifstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "basic_ofstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "basic_string")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "char_traits")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "common_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "conditional")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "decay")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "default_delete")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "deque")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "enable_if")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "enable_shared_from_this")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "extent")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "forward_list")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "function")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "has_virtual_destructor")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "integral_constant")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_abstract")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_arithmetic")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_array")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_base_of")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_class")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_compound")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_const")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_convertible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_copy_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_copy_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_default_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_destructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_empty")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_enum")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_floating_point")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_function")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_fundamental")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_integral")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_literal_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_lvalue_reference")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_member_function_pointer")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_member_object_pointer")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_member_pointer")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_move_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_move_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_nothrow_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_nothrow_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_nothrow_copy_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_nothrow_copy_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_nothrow_default_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_nothrow_destructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_nothrow_move_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_nothrow_move_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_object")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_pod")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_pointer")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_polymorphic")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_reference")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_rvalue_reference")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_same")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_scalar")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_signed")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_standard_layout")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivial")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_copy_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_copy_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_copyable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_default_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_destructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_move_assignable")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_trivially_move_constructible")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_union")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_unsigned")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_void")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "is_volatile")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "list")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "make_signed")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "make_unsigned")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "map")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "multimap")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "multiset")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "owner_less")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "pair")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "priority_queue")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "queue")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "rank")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "remove_all_extents")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "remove_const")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "remove_cv")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "remove_extent")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "remove_pointer")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "remove_reference")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "remove_volatile")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "result_of")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "set")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "shared_ptr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "stack")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "tuple")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "underlying_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "unique_ptr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "unordered_map")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "unordered_multimap")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "unordered_multiset")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "unordered_set")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "vector")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.template.type
  (#eq? @malterlib.template.type "weak_ptr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "CFStr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "CFUStr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "CFWStr")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "allocator_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "atomic_flag")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "char_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "const_iterator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "const_local_iterator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "const_pointer")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "const_reference")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "const_reverse_iterator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "difference_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "false_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "filebuf")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "fstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "hasher")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "ifstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "int_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "iterator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "key_compare")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "key_equal")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "key_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "local_iterator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "mapped_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "off_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "ofstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "pointer")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "pos_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "reference")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "reverse_iterator")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "size_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "state_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "string")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "traits_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "true_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "u16string")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "u32string")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "value_compare")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "value_type")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "wfilebuf")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "wfstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "wifstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "wofstream")
)

([
  (identifier)
  (field_identifier)
  (type_identifier)
  (namespace_identifier)
] @malterlib.type
  (#eq? @malterlib.type "wstring")
)

; Static token overrides from the Malterlib identifier table.

"[[" @malterlib.keyword.property.modifiers.brackets

"]]" @malterlib.keyword.property.modifiers.brackets

(auto) @malterlib.keyword.auto

(this) @malterlib.keyword.this

"inline" @malterlib.keyword.property.modifiers

"static" @malterlib.keyword.storage.class

"friend" @malterlib.keyword.access

"private" @malterlib.keyword.access

"protected" @malterlib.keyword.access

"public" @malterlib.keyword.access

"class" @malterlib.keyword.type.specification

"concept" @malterlib.keyword.type.specification

"enum" @malterlib.keyword.type.specification

"namespace" @malterlib.keyword.namespace

"struct" @malterlib.keyword.type.specification

"template" @malterlib.keyword.template

"union" @malterlib.keyword.type.specification

"#if" @malterlib.preprocessor.directive

"#ifdef" @malterlib.preprocessor.directive

"#ifndef" @malterlib.preprocessor.directive

"#elif" @malterlib.preprocessor.directive

"#else" @malterlib.preprocessor.directive

"#endif" @malterlib.preprocessor.directive

"#define" @malterlib.preprocessor.directive

"#include" @malterlib.preprocessor.directive