Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVFPOU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVFPOU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFPOU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 10:20:57 -0400
Received: from umbar.esa.informatik.tu-darmstadt.de ([130.83.163.30]:39808
	"EHLO umbar.esa.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id S261574AbVFPOUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 10:20:40 -0400
Date: Thu, 16 Jun 2005 16:20:39 +0200
From: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>
To: Sean Bruno <sean.bruno@dsl-only.net>
Cc: Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de>
References: <20050605204645.A28422@jurassic.park.msu.ru> <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org> <20050610184815.A13999@jurassic.park.msu.ru> <200506102247.30842.koch@esa.informatik.tu-darmstadt.de> <1118762382.9161.3.camel@home-lap>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline
In-Reply-To: <1118762382.9161.3.camel@home-lap>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2005 at 08:19:42AM -0700, Sean Bruno wrote:
> On Fri, 2005-06-10 at 22:47 +0200, Andreas Koch wrote:
> > On Friday 10 June 2005 16:48, Ivan Kokshaysky wrote:
> > > I'm still not sure if it boots though...
> >=20
> > It does :-))
> >=20
> > And the devices on the dock appear to be working, too! I could only tes=
t the=20
> > USB ports (my wife has currently taken posession of our FireWire MP3 pl=
ayer),=20
> > but according to the attached log, the mappings look sensible.
> > If you'd like me to perform other tests, let me know.
> >=20
> >From this comment it appears that the last patch does work?  Just
> curious if this thread it dead or if there is more work to be done.
>=20
> Sean

Not with regard to the PCI bridging/mapping issues, IMO. They
seem resolved, the devices in the dock are working fine. If someone
want to tackle the hotplugging problems, I am willing to assist by
performing experiments, though.

Andreas

--Lb0e7rgc7IsuDeGj
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIL3gYJKoZIhvcNAQcCoIILzzCCC8sCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
CfkwggUXMIIEA6ADAgECAgIRCDAJBgUrDgMCHQUAME0xCzAJBgNVBAYTAkRFMRUwEwYDVQQK
EwxUVSBEYXJtc3RhZHQxFjAUBgNVBAsTDUZCIEluZm9ybWF0aWsxDzANBgNVBAMTBlJCRyBD
QTAeFw0wNTAzMTUwOTIxNTVaFw0wNzAzMTQyMzAwMDBaMGcxCzAJBgNVBAYTAkRFMRUwEwYD
VQQKEwxUVSBEYXJtc3RhZHQxFjAUBgNVBAsTDUZCIEluZm9ybWF0aWsxDDAKBgNVBAsTA0VT
QTEbMBkGA1UEAxMSUHJvZi4gQW5kcmVhcyBLb2NoMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCB
iQKBgQDJ1OBpVkBWSGaMSeSUZWX4usQ2QUcyqvCIe/HangrILBgXUtjISISiM04h+d/5QIlu
WLLeCDWZ7aQPjvoLAapXlFXLMxkQN7yjeDjqxiKunm68Eg2jUQCva2XJPZ7T1scMXi35QT8Y
ZHKyHtKVdcoAupqISIPDrsogLO2KVktyUQIDAQABo4ICcTCCAm0wDgYDVR0PAQH/BAQDAgH4
MBEGCWCGSAGG+EIBAQQEAwIAsDAhBglghkgBhvhCAQ0EFBYSUkJHIENBIGNlcnRpZmljYXRl
MC4GA1UdEQQnMCWBI2tvY2hAZXNhLmluZm9ybWF0aWsudHUtZGFybXN0YWR0LmRlMGYGA1Ud
IARfMF0wWwYLKwYBBAHAbQEBAQMwTDBKBggrBgEFBQcCARY+aHR0cHM6Ly9jZXJ0LXJhLnJi
Zy5pbmZvcm1hdGlrLnR1LWRhcm1zdGFkdC5kZS9wb2xpY3kvY3BzLmh0bWwwgfYGA1UdHwSB
7jCB6zCB6KCB5aCB4oaB32xkYXA6Ly9jZXJ0LXJhLnJiZy5pbmZvcm1hdGlrLnR1LWRhcm1z
dGFkdC5kZTovY249cmJnJTIwY2EsT1U9RkIlMjBJbmZvcm1hdGlrLE89VFUlMjBEYXJtc3Rh
ZHQsQz1ERSxkYz1jZXJ0LXJhLCUyMGRjPXJiZywlMjBkYz1pbmZvcm1hdGlrLGRjPXR1LWRh
cm1zdGFkdCxkYz1ERT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/b2JqZWN0Q2xh
c3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnQwHQYDVR0OBBYEFCpAVFawshbNyxUfpvuqZC+SXWMe
MHUGA1UdIwRuMGyAFAv4K7e1iMgDfuscHFWuF7RLsMe7oVGkTzBNMQswCQYDVQQGEwJERTEV
MBMGA1UEChMMVFUgRGFybXN0YWR0MRYwFAYDVQQLEw1GQiBJbmZvcm1hdGlrMQ8wDQYDVQQD
EwZSQkcgQ0GCAQEwCQYFKw4DAh0FAAOCAQEAXcppP9j9Fj2ndZmy8tGYtoxwvCKd7aRMf60s
0NJU5wAF19mebUwXsPn9KuiPeZzO7fPoTdBpDjth5oKGMVFl9UU1gGqCN+8E4+Y1dGvpaGK7
8hJKF1/+QrmCbqa2hRVol6kkV6KWoZ4pgye+bjE9jwTSOARtOGc3IqRrxuRK/nG1lirAM+Ir
V48eKIHwckMTMArndbar7MCHLewZk8NhjvoFltEOmijGHcen3QrK91Ub6QsL1X3ar11eLUXu
eafAmI216WS+cdJtPWoxRajCv2yDr03zIay3qYMdpiLWvzr4VpalKYs1YDjbUO3aMDzat7ix
yUppqEJGJADufbLuvjCCBNowggPGoAMCAQICAQEwCQYFKw4DAh0FADBNMQswCQYDVQQGEwJE
RTEVMBMGA1UEChMMVFUgRGFybXN0YWR0MRYwFAYDVQQLEw1GQiBJbmZvcm1hdGlrMQ8wDQYD
VQQDEwZSQkcgQ0EwHhcNMDIxMjAxMDg1OTU5WhcNMDcxMjAxMDg1OTU5WjBNMQswCQYDVQQG
EwJERTEVMBMGA1UEChMMVFUgRGFybXN0YWR0MRYwFAYDVQQLEw1GQiBJbmZvcm1hdGlrMQ8w
DQYDVQQDEwZSQkcgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDD6W4mxb9y
WCzbb/BkIPup8fDV9oG2JSTgZ6LojzjOrg93OFEo+yaFjovnZ8TTEYvCKQ2y+h6rlfTIp6Tq
zK+w54EsLt9IYJnaBuOwqSPy2zkvKyS3gPFaJ0xWMBntBkFtcFKFci0XUk+JhKssYwG7p9Dy
xBCsZGQ1dyBVhCN6CKsJTwvkQoV7DoL+rfDVj6/dyLYjrfigrGGRY+jQTMgl9RBeL2XGgR6n
7HFI5B+RVTcKNQziveb7PnyrzokEcerZcuQ+rrGyfnXoFc5mAQ/ESjrsT+0nnQzLDxmp/SYD
De0tpXlWomaN/CgiEjwSkRWSUM//jKJNtxoPhJoBOb8DAgMBAAGjggHLMIIBxzARBglghkgB
hvhCAQEEBAMCAAQwEgYDVR0TAQH/BAgwBgEB/wIBATAPBgNVHQ8BAf8EBQMDB4YAMIH2BgNV
HR8Ege4wgeswgeiggeWggeKGgd9sZGFwOi8vY2VydC1yYS5yYmcuaW5mb3JtYXRpay50dS1k
YXJtc3RhZHQuZGU6L2NuPXJiZyUyMGNhLE9VPUZCJTIwSW5mb3JtYXRpayxPPVRVJTIwRGFy
bXN0YWR0LEM9REUsZGM9Y2VydC1yYSwlMjBkYz1yYmcsJTIwZGM9aW5mb3JtYXRpayxkYz10
dS1kYXJtc3RhZHQsZGM9REU/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVj
dENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MB0GA1UdDgQWBBQL+Cu3tYjIA37rHBxVrhe0
S7DHuzB1BgNVHSMEbjBsgBQL+Cu3tYjIA37rHBxVrhe0S7DHu6FRpE8wTTELMAkGA1UEBhMC
REUxFTATBgNVBAoTDFRVIERhcm1zdGFkdDEWMBQGA1UECxMNRkIgSW5mb3JtYXRpazEPMA0G
A1UEAxMGUkJHIENBggEBMAkGBSsOAwIdBQADggEBALG2hzYbLKxk1XhmiAasTeuuJ2U12cdR
E6EgTzuR1UXJP6Iv7XHmjfX4Ox3QmbuunA51fYBFfbIzWAXw+rp1gm3JnJpvYQUWl4wpNg17
+bv2plCLrszWYKMCfStFwvpMKPOuBvezfWbP/Gwse4vVzFlNDayptdngwl5tgPQVibiW4fab
61FOkjoRBMFCcmb17eburzPVtik1XF/scQiGysLYjvujKy+6f5PlpHflBqMFSvIciV8bV3WE
9gdjcArZv6odSHCO0IoAGQlFzl++8AGLtpLndcXBEn1WuoyOphhXoESeT+DuB440otYPObvW
xVrz4WwYUAMXNtteLwTbZ7ExggGtMIIBqQIBATBTME0xCzAJBgNVBAYTAkRFMRUwEwYDVQQK
EwxUVSBEYXJtc3RhZHQxFjAUBgNVBAsTDUZCIEluZm9ybWF0aWsxDzANBgNVBAMTBlJCRyBD
QQICEQgwCQYFKw4DAhoFAKCBsTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0wNTA2MTYxNDIwMzlaMCMGCSqGSIb3DQEJBDEWBBRExe+pum3/kUTHSNDcBzmL
zKbpEjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggq
hkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASBgE1M
QhxmFnqNshS3CncnSmW5lLAXgGUT9ThkuNIcChuq7+FnOIoOAjxzrzTC9qS2vrVwzVC4Rfgp
ZKmZQE6aDnPIWiKDziai/Hhlb7NPg5rk8H7/VZIWZDgsu9BJBka/74pKNri+5qkNehW3/VkI
yZgB7IxNbMZaEBo1299cqrcI

--Lb0e7rgc7IsuDeGj--
