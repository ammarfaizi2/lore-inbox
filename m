Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSATIIi>; Sun, 20 Jan 2002 03:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288061AbSATII3>; Sun, 20 Jan 2002 03:08:29 -0500
Received: from cervnet.com ([216.58.141.4]:52484 "EHLO CervNet.COM")
	by vger.kernel.org with ESMTP id <S288059AbSATIIU>;
	Sun, 20 Jan 2002 03:08:20 -0500
From: "jeev" <naptime@cervnet.com>
To: "'Dan Chen'" <crimsun@email.unc.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.17 problem.
Date: Sun, 20 Jan 2002 00:08:18 -0800
MIME-Version: 1.0
Message-ID: <002d01c1a189$9f45ae60$0200a8c0@mainframe>
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_0028_01C1A146.904C80C0";
	micalg=SHA1
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020120062620.GA25787@opeth.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0028_01C1A146.904C80C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Also this is an asus a7v133 motherboard with an athlon 1.4ghz, just
curious to see if others have these sorts of problems. Also forgot to
add this:

EXT2-fs error (device ide0(3,1)): ext2_free_blocks: bit already cleared
for block 7942458

Got that while rm'ing a 100meg file as root.

j

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Dan Chen
> Sent: Saturday, January 19, 2002 10:26 PM
> To: jeev
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Linux 2.4.17 problem.
> 
> Would you run those through ksymoops and repost?
> 
> On Sat, Jan 19, 2002 at 09:24:56PM -0800, jeev wrote:
> > Hi, im running slackware with the kernel 2.4.17, when I tar -zxvf a
big
> > file, ie. hlds_l_3108_full.tar.gz.
> >
> > It cuts off saying format violated..
> > This is an amd 1.4ghz with 768 mbram 41gb 7200rpm harddrive (brand
new
> > stuff)
> 
> --
> Dan Chen                 crimsun@email.unc.edu
> GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

------=_NextPart_000_0028_01C1A146.904C80C0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII8TCCAoAw
ggHpoAMCAQICAwZBjzANBgkqhkiG9w0BAQIFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAxMTIwNjA2MDYzM1oXDTAyMTIwNjA2MDYzM1owRTEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEiMCAGCSqGSIb3DQEJARYTbmFwdGltZUBjZXJ2bmV0LmNvbTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAz0mQ8rzcTgacUdJdwyW6PzGeYHxOaslWWCUrFmvuaO8q
2NcC8hTieOkuOknDzNz7uUR0ab8n+pXOFYThs1muaMK11VRp4BIkiRJe/41diCSjFWb8X1XhqGpU
pB5DtTHGTT+G6XOa0cCUobIehi8zuP9wRKgkaycNQb8owCQVc8UCAwEAAaMwMC4wHgYDVR0RBBcw
FYETbmFwdGltZUBjZXJ2bmV0LmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBAgUAA4GBAFW+
KAHeKTLKrga03WUsMHpsk9NW77W1nzafKDqyHYnBXp1yJkXYHXfSpBXt1teCJAptPDJ9NKmq54X2
tOCrrkt2tv45La8yPuY17EEeKawK/g2d9hNvuPMh9qfSNoz8XUbviDMpWmrPVuINlFLN1g55kCWq
H13QE06B+sk4AUFzMIIDLTCCApagAwIBAgIBADANBgkqhkiG9w0BAQQFADCB0TELMAkGA1UEBhMC
WkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFU
aGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lv
bjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxw
ZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTk2MDEwMTAwMDAwMFoXDTIwMTIzMTIzNTk1
OVowgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTCBnzANBgkqhkiG9w0B
AQEFAAOBjQAwgYkCgYEA1GnX1LCUZFtx6UfYDFG26nKRsIRefS0Nj3sS34UldSh0OkIsYyeflXtL
734Zhx2G6qPduc6WZBrCFG5ErHzmj+hND3EfQDimAKOHePb5lIZererAXnbr2RSjXW56fAylS1V/
Bhkpf56aJtVquzgkCGqYx7Hao5iR/Xnb5VrEHLkCAwEAAaMTMBEwDwYDVR0TAQH/BAUwAwEB/zAN
BgkqhkiG9w0BAQQFAAOBgQDH7JJ+Tvj1lqVnYiqk8E0RYNBvjWBYYawmu1I1XAjPMPuoSpaKH2JC
I4wXD/S6ZJwXrEcp352YXtJsYHFcoqzceePnbgBHH7UNKOgCneSa/RP0ptl8sfjcXyMmCZGAc9AU
G95DqYMl8uacLxXK/qarigd1iwzdUYRr5PjRzneigTCCAzgwggKhoAMCAQICEGZFcrfMdPXPY3ZF
hNAukQEwDQYJKoZIhvcNAQEEBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENh
cGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNV
BAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3Rl
LmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wNDA4MjcyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEd
MBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWls
IFJTQSAyMDAwLjguMzAwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7Sbngn
Z4HF2ogZgpcO40QpimM1Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWa
NRqdknWoJ67Ycvm6AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFp
AgMBAAGjTjBMMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNV
HRMBAf8ECDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQAxsUtHXfkBceX1
U2xdedY9mMAmE2KBIqcS+CKV6BtJtyd7BDm6/ObyJOuR+r3sDSo491BVqGz3Da1MG7wD9LXrokef
bKIMWI0xQgkRbLAaadErErJAXWr5edDqLiXdiuT82w0fnQLzWtvKPPZE6iZph39Ins6ln+eE2Mli
Yq0FxjGCA2kwggNlAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBl
MRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNh
dGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwZB
jzAJBgUrDgMCGgUAoIICJDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0wMjAxMjAwODA4MThaMCMGCSqGSIb3DQEJBDEWBBS1q2UlTEplvtEX3n/kixoO/SYgfzBnBgkq
hkiG9w0BCQ8xWjBYMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTCBqwYJKwYBBAGCNxAE
MYGdMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlD
YXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMx
KDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwZBjzCBrQYLKoZIhvcN
AQkQAgsxgZ2ggZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNV
BAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2
aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAIDBkGPMA0GCSqG
SIb3DQEBAQUABIGAlRzlqtIEz+FclR8OcfDoMZ5crA/b2VVhye69x+LWEPlenvh6x/3TWAMwPo2N
XBJQ5TR82rolWaAi3HNjnWIgA0R7njh3Lkt9IQYwADrIzEk+DIpBDC0SVpcOPpuVJKh0AsnkyKJX
uDjBEWPyQLTi8liwu0ALo7rqUPHNI9/S16wAAAAAAAA=

------=_NextPart_000_0028_01C1A146.904C80C0--

