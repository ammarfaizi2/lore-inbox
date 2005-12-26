Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVLZTFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVLZTFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 14:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVLZTFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 14:05:15 -0500
Received: from mailspool.ops.uunet.co.za ([196.7.0.140]:27652 "EHLO
	mailspool.ops.uunet.co.za") by vger.kernel.org with ESMTP
	id S932103AbVLZTFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 14:05:13 -0500
Message-ID: <43B03ECB.5020301@kroon.co.za>
Date: Mon, 26 Dec 2005 21:04:43 +0200
From: Jaco Kroon <jaco@kroon.co.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20051007
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: rlrevell@joe-job.com, jason@stdbev.com, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz, s0348365@sms.ed.ac.uk
Subject: Re: recommended mail clients
References: <43AF7724.8090302@kroon.co.za>	<43AFB005.50608@kroon.co.za>	<1135607906.5774.23.camel@localhost.localdomain>	<200512261535.09307.s0348365@sms.ed.ac.uk>	<1135619641.8293.50.camel@mindpipe>	<0f197de4ee389204cc946086d1a04b54@stdbev.com>	<1135621183.8293.64.camel@mindpipe>	<43B03658.9040108@kroon.co.za> <20051226105822.538a31d9.rdunlap@xenotime.net>
In-Reply-To: <20051226105822.538a31d9.rdunlap@xenotime.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020503040006030903090605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020503040006030903090605
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:
> On Mon, 26 Dec 2005 20:28:40 +0200 Jaco Kroon wrote:
> 
> 
>>Lee Revell wrote:
>>
>>>On Mon, 2005-12-26 at 12:09 -0600, Jason Munro wrote:
>>>
>>>
>>>>On 11:54:00 am 26 Dec 2005 Lee Revell <rlrevell@joe-job.com> wrote:
>>>>
>>>><snip>
>>>>
>>>>>>Dare I say it, KMail has also been doing the Right Thing for a
>>>>>>long time. It will only line wrap things that you insert by
>>>>>>typing; pastes are left untouched.
> 
> 
> sylpheed also DTRT.  (http://sylpheed.good-day.net)
> It's a simple, clean email client.
> 
> 
>>I've looked at a few clients and it seems I'm stuck with mozilla for at
>>least a while.  Whilst probably the buggiest client there is it does
>>look like it's the best suited for what I want.  I might switch to
>>FireFox (which iirc does have an "insert file" feature - which might
>>also solve this problem).
> 
> 
> Firefox has an email interface??

Thunderbird ... (my brain is rotting ok ... ?)

>>For the moment though I'm quickly hacking together a bash script that
>>wraps the sendmail binary that can be used specifically for submitting
>>patches (the intent is to perform certain checks for Signed-of-by lines,
>>correct [PATCH] subject and so forth).  If anybody else is interrested
>>I'd be more than happy to share (albeit I suspect the usefullness will
>>be seriously limited).
> 
> Greg KH and Paul Jackson have both written scripts for this.
> And there may be one in the quilt package.
> 
> Paul's (python) is at
>   http://www.speakeasy.org/~pj99/sgi/sendpatchset
> I don't recall where Greg's is (perl).

/me grabs a copy.


-- 
There are only 10 kinds of people in this world,
  those that understand binary and those that don't.
http://www.kroon.co.za/

--------------ms020503040006030903090605
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII5TCC
As0wggI2oAMCAQICAw3p1jANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI4MjExMjIzWhcNMDYwMTI4MjExMjIz
WjBCMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR8wHQYJKoZIhvcNAQkBFhBq
YWNvQGtyb29uLmNvLnphMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4CsLuOWD
wimwAv4QLdlT99frJCwzUBVQNL7c7x4ufEquAH6RamWfQyQHzykEJM8NeMIrfb+k3fZEi+ZU
g5sq2uIqzOuCJsIj0x3LnoydXTikbv1AFWQDEuqITlroA8bGJE/mMlbPrKyDACPo5cQAzUQz
LAg7LQQQVkKNWH4eeXUwZ5lOZEWWno0P5DXHdSLQxCshgWVPRrbtKe25WGObqJMa//1T5qX8
0mKIdAbHlz90BwgX/MjLp0BpXTii2653ScOujCLTC3cPdDUDK68qG7RqatVw5+HE/npJIWa1
0TxJUp5Ii8nPbGPzpEWQmZ8TjkjMs26w80PPPKh2Vh2siQIDAQABoy0wKzAbBgNVHREEFDAS
gRBqYWNvQGtyb29uLmNvLnphMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAqXNX
QEMTVQoj3JoEwK9vlfqSVz5ZEUklpgEhwFJsD+PKa/LgUGVHk3Gw8wws4+wZxmpOsJ7vdiWL
y8zlX7HfPWMcbibTi6C7nT6WahqdeAo3kVjhnMqJ3Sf6sX0JGl9bWfIhgmIVy/ZdM2ztrXwd
rbWiT7un5lM05D4YPCNH9fcwggLNMIICNqADAgECAgMN6dYwDQYJKoZIhvcNAQEEBQAwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1MDEyODIx
MTIyM1oXDTA2MDEyODIxMTIyM1owQjEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJl
cjEfMB0GCSqGSIb3DQEJARYQamFjb0Brcm9vbi5jby56YTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAOArC7jlg8IpsAL+EC3ZU/fX6yQsM1AVUDS+3O8eLnxKrgB+kWpln0Mk
B88pBCTPDXjCK32/pN32RIvmVIObKtriKszrgibCI9Mdy56MnV04pG79QBVkAxLqiE5a6APG
xiRP5jJWz6ysgwAj6OXEAM1EMywIOy0EEFZCjVh+Hnl1MGeZTmRFlp6ND+Q1x3Ui0MQrIYFl
T0a27SntuVhjm6iTGv/9U+al/NJiiHQGx5c/dAcIF/zIy6dAaV04otuud0nDrowi0wt3D3Q1
AyuvKhu0amrVcOfhxP56SSFmtdE8SVKeSIvJz2xj86RFkJmfE45IzLNusPNDzzyodlYdrIkC
AwEAAaMtMCswGwYDVR0RBBQwEoEQamFjb0Brcm9vbi5jby56YTAMBgNVHRMBAf8EAjAAMA0G
CSqGSIb3DQEBBAUAA4GBAKlzV0BDE1UKI9yaBMCvb5X6klc+WRFJJaYBIcBSbA/jymvy4FBl
R5NxsPMMLOPsGcZqTrCe73Yli8vM5V+x3z1jHG4m04ugu50+lmoanXgKN5FY4ZzKid0n+rF9
CRpfW1nyIYJiFcv2XTNs7a18Ha21ok+7p+ZTNOQ+GDwjR/X3MIIDPzCCAqigAwIBAgIBDTAN
BgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTES
MBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UE
CxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0
aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UEBhMC
WkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAK
MNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYB
Af8CAQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBl
cnNvbmFsRnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYD
VQQDExFQcml2YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2as
Zw9/r6y+whehQ5aUnX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSe
JVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHT
HUb/XV9lTzGCAzswggM3AgEBMGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBD
b25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFp
bCBJc3N1aW5nIENBAgMN6dYwCQYFKw4DAhoFAKCCAacwGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUxMjI2MTkwNDQzWjAjBgkqhkiG9w0BCQQxFgQUWC+I
i/+9v6Uv3W9D3aIWA6OHE3EwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG
9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYB
BAGCNxAEMWswaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcg
KFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3Vpbmcg
Q0ECAw3p1jB6BgsqhkiG9w0BCRACCzFroGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRo
YXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBG
cmVlbWFpbCBJc3N1aW5nIENBAgMN6dYwDQYJKoZIhvcNAQEBBQAEggEAlxxooLIFq35h9rCJ
LcoifDNinxYioPziaHf3ACVTtmxOnYDI6oi9fE+U2h4d03TCYsnZUOHRkP1xl9I146HQ3HWF
1pw0cfauvL2b9ElJcZ5DvLE7iG05R3xMUB75M9Avq0avyHf5psUhoqXP55EPi7v8HQbsEvnp
x+3FV9+a+hAVTe6zdieOupSZlTPzgqPm9VxB4x8cIBniP6QZBSmMlAVcjB82iirzlIwGIu7X
ssNQey7PJyydYGOcHpFEhbLw5w8TcTjb4/7LOp1KEOacKPAr8I7q4J0/stOw5hE8Wkdq4KPK
FfxoI3+17l4uNXu8iDZMR6uEfYRTCUOy/+eQ3QAAAAAAAA==
--------------ms020503040006030903090605--
