Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVLIKqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVLIKqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbVLIKqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:46:04 -0500
Received: from erik-slagter.demon.nl ([83.161.107.130]:1960 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932083AbVLIKqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:46:02 -0500
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
From: Erik Slagter <erik@slagter.name>
To: Jens Axboe <axboe@suse.de>
Cc: Randy Dunlap <randy_d_dunlap@linux.intel.com>,
       Jeff Garzik <jgarzik@pobox.com>, hch@infradead.org, mjg59@srcf.ucam.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <20051209103937.GE26185@suse.de>
References: <20051208030242.GA19923@srcf.ucam.org>
	 <20051208091542.GA9538@infradead.org>
	 <20051208132657.GA21529@srcf.ucam.org>
	 <20051208133308.GA13267@infradead.org>
	 <20051208133945.GA21633@srcf.ucam.org>
	 <20051208134438.GA13507@infradead.org>
	 <1134062330.1732.9.camel@localhost.localdomain>
	 <43989B00.5040503@pobox.com>
	 <20051208133144.0f39cb37.randy_d_dunlap@linux.intel.com>
	 <1134121522.27633.7.camel@localhost.localdomain>
	 <20051209103937.GE26185@suse.de>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-zVPFfpSIofJFQa0dLvEJ"
Date: Fri, 09 Dec 2005 11:45:45 +0100
Message-Id: <1134125145.27633.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-3.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zVPFfpSIofJFQa0dLvEJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-12-09 at 11:39 +0100, Jens Axboe wrote:

> > IMHO available infrastructure (and hardware abstraction!) should be use=
d
> > instead of being stubborn and pretend we know everything about any
> > hardware.
>=20
> It's not about being stubborn, it's about maintaining and working on a
> clean design. The developers have to do that, not the users. So forgive
> people for being a little cautious about shuffling all sorts of ACPI
> into the scsi core and/or drivers. We always need to think long term
> here.
>=20
> Users don't care about the maintainability and cleanliness of the code,
> they really just want it to work. Which is perfectly understandable.

I perfectly understand that, what I do object against, is rejecting a
concept (like this) totally because the developers(?) do not like the
mechanism that's used (although ACPI is used everywhere else in the
kernel). At least there might be some discussion where this sort of code
belongs to make the design clean and easily maintainable, instead of
instantly completely rejecting the concept, because OP simply doesn't
like acpi.

--=-zVPFfpSIofJFQa0dLvEJ
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIILzCCAnIw
ggHboAMCAQICAw/xBDANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI5MTc0MTQ0WhcNMDYxMTI5MTc0MTQ0WjBqMRAwDgYDVQQE
EwdTbGFndGVyMRUwEwYDVQQqEwxFcmlrIE1hcnRpam4xHTAbBgNVBAMTFEVyaWsgTWFydGlqbiBT
bGFndGVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFtZTCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAtYqGuTSGbsTHZPiKQnNmvpVaxVuBZS6rV5xuKD47J9hz8Vq3Xh4PpuGYNW5L
vevp80oj6sYAhNuU380UNRqALFaer8MtG6fXpvBgq+MCxVQzMyYxAnopqWlZQIUQNQX9wZmI0gVv
gY6vwcXRBXkMyrzm41dy4oFwh+PTj3U+xwcCAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0BzbGFn
dGVyLm5hbWUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCf5+l4khcSjUOL8WcuJ7Q1
eXhSPe0VJEsHSfVJCNFmfFZFiGZNwQRliOuGFxSy+uPb8ZVIZ3cBIen/K0k2hWS6pCiDm3xNdkFU
mhWsibmyMoc91I0Re2ZWPmL6isxiyr56Qv7vNz2UHSinLJr/QtsvRv/RKFlcO1gm1wsCOPkyITCC
AnIwggHboAMCAQICAw/xBDANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI5MTc0MTQ0WhcNMDYxMTI5MTc0MTQ0WjBqMRAwDgYD
VQQEEwdTbGFndGVyMRUwEwYDVQQqEwxFcmlrIE1hcnRpam4xHTAbBgNVBAMTFEVyaWsgTWFydGlq
biBTbGFndGVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFtZTCBnzANBgkqhkiG9w0B
AQEFAAOBjQAwgYkCgYEAtYqGuTSGbsTHZPiKQnNmvpVaxVuBZS6rV5xuKD47J9hz8Vq3Xh4PpuGY
NW5Lvevp80oj6sYAhNuU380UNRqALFaer8MtG6fXpvBgq+MCxVQzMyYxAnopqWlZQIUQNQX9wZmI
0gVvgY6vwcXRBXkMyrzm41dy4oFwh+PTj3U+xwcCAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0Bz
bGFndGVyLm5hbWUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCf5+l4khcSjUOL8Wcu
J7Q1eXhSPe0VJEsHSfVJCNFmfFZFiGZNwQRliOuGFxSy+uPb8ZVIZ3cBIen/K0k2hWS6pCiDm3xN
dkFUmhWsibmyMoc91I0Re2ZWPmL6isxiyr56Qv7vNz2UHSinLJr/QtsvRv/RKFlcO1gm1wsCOPky
ITCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1
bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMT
G1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJl
ZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNa
LIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUq
VIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1Ud
HwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWls
Q0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVs
Mi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYf
qi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa
9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggJmMIICYgIBATBpMGIxCzAJ
BgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQD
EyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD/EEMAkGBSsOAwIaBQCgggFT
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTIwOTEwNDU0NVow
IwYJKoZIhvcNAQkEMRYEFHaT1K/FrW7uKmPzVRJjpKNCtw4gMHgGCSsGAQQBgjcQBDFrMGkwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMP8QQwegYLKoZIhvcNAQkQ
Agsxa6BpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD/EEMA0G
CSqGSIb3DQEBAQUABIGAljJ+cUyjDa721eAAMjeAZApKH6iKOnsAnW2hMV229FLKGSPKDDWtCcrh
X+lmlf1ZAILXvzQC+5mIAdsIMU2nWfJ7oSEsNQDpjtMol4x3P6467LwTldN9dQUa7Opt39RkRMXZ
ursKoxkMZhSJ5O1H40Mr5NnXekJMLnPT86dhY3IAAAAAAAA=


--=-zVPFfpSIofJFQa0dLvEJ--
