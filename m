Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbVJ1Qki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVJ1Qki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVJ1Qki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:40:38 -0400
Received: from smtp06.wanadoo.nl ([194.134.35.146]:25643 "EHLO
	smtp06.wanadoo.nl") by vger.kernel.org with ESMTP id S1030246AbVJ1Qkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:40:37 -0400
Message-ID: <43625484.30100@lazarenko.net>
Date: Fri, 28 Oct 2005 18:40:36 +0200
From: Vladimir Lazarenko <vlad@lazarenko.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: thockin@hockin.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon64 X2 Dual-core and 4GB
References: <4361408B.60903@lazarenko.net> <m1irvhbqvo.fsf@ebiederm.dsl.xmission.com> <20051028160403.GA26286@hockin.org>
In-Reply-To: <20051028160403.GA26286@hockin.org>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040101060201050102080309"
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "dinosaur.lazarenko.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  >>>Thus, the question - would I be able to use whole 4G
	RAM with dual-core amd and >>>kernel with SMP compiled for i686? > > >
	Why would you use a dual core AMD in 32 bit mode? Just build an x86_64 >
	kernel. > > If you want to use 4GB in 32 bit mode, you *need* remapping
	(or you lose > part of your memory). Remapping means you have MORE than
	4 GB of physical > address, which means you need PAE to use it at all.
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040101060201050102080309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>>>Thus, the question - would I be able to use whole 4G RAM with dual-core amd and
>>>kernel with SMP compiled for i686?
> 
> 
> Why would you use a dual core AMD in 32 bit mode?  Just build an x86_64
> kernel.
> 
> If you want to use 4GB in 32 bit mode, you *need* remapping (or you lose
> part of your memory).  Remapping means you have MORE than 4 GB of physical
> address, which means you need PAE to use it at all.

Because I find my distribution's 64-bit release reasonably unstable yet? :)

Or can I somehow build an x86_64 kernel and keep using 32-bit libc?

--------------ms040101060201050102080309
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ2zCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggNIMIICsaADAgECAgMPl0owDQYJKoZIhvcNAQEE
BQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1
MTAwNDE4Mjk1NloXDTA2MTAwNDE4Mjk1NlowgZgxEjAQBgNVBAQTCUxhemFyZW5rbzERMA8G
A1UEKhMIVmxhZGltaXIxGzAZBgNVBAMTElZsYWRpbWlyIExhemFyZW5rbzEhMB8GCSqGSIb3
DQEJARYSdmxhZEBsYXphcmVua28ubmV0MS8wLQYJKoZIhvcNAQkBFiB2bGFkaW1pci5sYXph
cmVua29AbG9naWNhY21nLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMhN
65wBwy12UD+rjqjhBDMm8/6sYE+YHQmJMgTb/Cxy+Sp00ISDel7/FiLvVtKAo667N43VeFzT
p+7BWKxC0OJAFddayiWFw5sZCEL28qY2lHnolrpJMbVIzUoqrSkPjgZ9GNI93Ri7AWkMCF9X
uRFW0I0Lbb2gYH2fnpdloO917DLyXVuBxOyPUpu1TeP+oHbi8whPdrhFx8Ep37sP13srk5tf
ISzaXdJzEVWOaLTyIL5tMSlCuBJibmcDm9/2qCLW+c1eAxiQwmafH4tJ5WPch2wclEXlt7tw
tGe6vK0Se2B8TvgZmOaY78wIp0DBVrP4+wsMnCbcPHtk+sY1d/8CAwEAAaNRME8wPwYDVR0R
BDgwNoESdmxhZEBsYXphcmVua28ubmV0gSB2bGFkaW1pci5sYXphcmVua29AbG9naWNhY21n
LmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBACfGbOm/RbyWFmOR+w4Vk8XY
umCjlfqb+icqbKENKvuG4DOQr6QaTtRT+/ATA3yrooYfQWuflDIEPS+SbNyjfpNyyFiYB8OS
rfclJ+B+ikvEP7LweNoL3EV1SrzeyJ3YrcqHAhoNqvB66dVQCy04RFvaRI+fC3I79Zd748gf
ESqyMIIDSDCCArGgAwIBAgIDD5dKMA0GCSqGSIb3DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNTEwMDQxODI5NTZaFw0wNjEwMDQx
ODI5NTZaMIGYMRIwEAYDVQQEEwlMYXphcmVua28xETAPBgNVBCoTCFZsYWRpbWlyMRswGQYD
VQQDExJWbGFkaW1pciBMYXphcmVua28xITAfBgkqhkiG9w0BCQEWEnZsYWRAbGF6YXJlbmtv
Lm5ldDEvMC0GCSqGSIb3DQEJARYgdmxhZGltaXIubGF6YXJlbmtvQGxvZ2ljYWNtZy5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDITeucAcMtdlA/q46o4QQzJvP+rGBP
mB0JiTIE2/wscvkqdNCEg3pe/xYi71bSgKOuuzeN1Xhc06fuwVisQtDiQBXXWsolhcObGQhC
9vKmNpR56Ja6STG1SM1KKq0pD44GfRjSPd0YuwFpDAhfV7kRVtCNC229oGB9n56XZaDvdewy
8l1bgcTsj1KbtU3j/qB24vMIT3a4RcfBKd+7D9d7K5ObXyEs2l3ScxFVjmi08iC+bTEpQrgS
Ym5nA5vf9qgi1vnNXgMYkMJmnx+LSeVj3IdsHJRF5be7cLRnurytEntgfE74GZjmmO/MCKdA
wVaz+PsLDJwm3Dx7ZPrGNXf/AgMBAAGjUTBPMD8GA1UdEQQ4MDaBEnZsYWRAbGF6YXJlbmtv
Lm5ldIEgdmxhZGltaXIubGF6YXJlbmtvQGxvZ2ljYWNtZy5jb20wDAYDVR0TAQH/BAIwADAN
BgkqhkiG9w0BAQQFAAOBgQAnxmzpv0W8lhZjkfsOFZPF2Lpgo5X6m/onKmyhDSr7huAzkK+k
Gk7UU/vwEwN8q6KGH0Frn5QyBD0vkmzco36TcshYmAfDkq33JSfgfopLxD+y8HjaC9xFdUq8
3sid2K3KhwIaDarweunVUAstOERb2kSPnwtyO/WXe+PIHxEqsjGCAzswggM3AgEBMGkwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPl0owCQYFKw4D
AhoFAKCCAacwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUx
MDI4MTY0MDM2WjAjBgkqhkiG9w0BCQQxFgQUQgwRZ+rXkc/ZUY18snfkUW9MzQEwUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw+XSjB6BgsqhkiG9w0BCRACCzFr
oGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPl0ow
DQYJKoZIhvcNAQEBBQAEggEAQXwerKLxd8cdBrEF4yK7onI687uYIvjKtQ52GxsUBT2fTUTN
7AyEe3qHZABRV3Nt+WrMDgtyQQhMH0yV7HEWq3kXSwY0ZbchZubw/0kKmMjUS6yOAKzYbEso
JKLnYD9J1Xq5mauuc6XSDkmhtcAx5jMq/cqFEeBF/MUu9K9wNWdds8WELGUaaWb9TKydKFyC
SWjfyWl1P0LOWLpDN0MZfUdQfTaOATTUqBLGp/ar3ckEAidj5+OMrocNxSHTI5//864HmvPK
4eZDL7h/XHPcKcoTg+NNZLbunH0sbvfAwA2iXfTY1KknwKK62gYngLQTv+dHWNIXcz7MsUpw
SQt+LQAAAAAAAA==
--------------ms040101060201050102080309--

