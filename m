Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVDLMsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVDLMsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVDLMqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:46:13 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:8378 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S262329AbVDLMoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:44:08 -0400
Subject: Re: [ANNOUNCE] git-pasky-0.3
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Petr Baudis <pasky@ucw.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
In-Reply-To: <20050411135758.GA3524@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
	 <20050409200709.GC3451@pasky.ji.cz>
	 <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	 <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	 <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz>
	 <20050411015852.GI5902@pasky.ji.cz>  <20050411135758.GA3524@pasky.ji.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-227+5hi1VghJuAPrO6PH"
Date: Tue, 12 Apr 2005 14:47:25 +0200
Message-Id: <1113310045.23299.15.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-227+5hi1VghJuAPrO6PH
Content-Type: multipart/mixed; boundary="=-1QMEKeKIFwk3bFajyYb1"


--=-1QMEKeKIFwk3bFajyYb1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-11 at 15:57 +0200, Petr Baudis wrote:
>   Hello,
>=20
>   here goes git-pasky-0.3, my set of patches and scripts upon
> Linus' git, aimed at human usability and to an extent a SCM-like usage.
>=20

Its pretty dependant on where VERSION is located.  This patch fixes
that. (PS, I left the output of 'git diff' as is to ask about the
following stuff after the proper diff ...)


Regards,

--=20
Martin Schlemmer


--=-1QMEKeKIFwk3bFajyYb1
Content-Disposition: attachment; filename=add_version.patch
Content-Type: text/x-patch; name=add_version.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIC0JMjAwNS0wNC0xMiAxNDozNjo0NC4zODQ4MjIwMDAgKzAyMDANCisrKyBNYWtlZmlsZQky
MDA1LTA0LTEyIDE0OjMzOjE0LjAwMDAwMDAwMCArMDIwMA0KQEAgLTE5LDEwICsxOSwxNCBAQA0K
IAlnaXRjb21taXQuc2ggZ2l0ZGlmZi1kbyBnaXRkaWZmLnNoIGdpdGxvZy5zaCBnaXRscy5zaCBn
aXRsc29iai5zaCBcDQogCWdpdG1lcmdlLnNoIGdpdHB1bGwuc2ggZ2l0cm0uc2ggZ2l0dGFnLnNo
IGdpdHRyYWNrLnNoDQogDQotYWxsOiAkKFBST0cpDQorR0VOX1NDUklQVD0gZ2l0dmVyc2lvbi5z
aA0KIA0KLWluc3RhbGw6ICQoUFJPRykNCi0JaW5zdGFsbCAkKFBST0cpICQoU0NSSVBUKSAkKEhP
TUUpL2Jpbi8NCitWRVJTSU9OPSBWRVJTSU9ODQorDQorYWxsOiAkKFBST0cpICQoR0VOX1NDUklQ
VCkNCisNCitpbnN0YWxsOiAkKFBST0cpICQoR0VOX1NDUklQVCkNCisJaW5zdGFsbCAkKFBST0cp
ICQoU0NSSVBUKSAkKEdFTl9TQ1JJUFQpICQoSE9NRSkvYmluLw0KIA0KIExJQlM9IC1sc3NsIC1s
eg0KIA0KQEAgLTY3LDggKzcxLDE0IEBADQogcmVhZC1jYWNoZS5vOiBjYWNoZS5oDQogc2hvdy1k
aWZmLm86IGNhY2hlLmgNCiANCitnaXR2ZXJzaW9uLnNoOiAkKFZFUlNJT04pDQorCUBybSAtZiAk
QA0KKwlAZWNobyAiIyEvYmluL3NoIiA+ICRADQorCUBlY2hvICJlY2hvIFwiJChzaGVsbCBjYXQg
JChWRVJTSU9OKSlcIiIgPj4gJEANCisJQGNobW9kICt4ICRADQorDQogY2xlYW46DQotCXJtIC1m
ICoubyAkKFBST0cpIHRlbXBfZ2l0X2ZpbGVfKg0KKwlybSAtZiAqLm8gJChQUk9HKSB0ZW1wX2dp
dF9maWxlXyogJChHRU5fU0NSSVBUKQ0KIA0KIGJhY2t1cDogY2xlYW4NCiAJY2QgLi4gOyB0YXIg
Y3p2ZiBkaXJjYWNoZS50YXIuZ3ogZGlyLWNhY2hlDQotLS0gLQkyMDA1LTA0LTEyIDE0OjM2OjQ0
LjQxNzI4NDAwMCArMDIwMA0KKysrIGdpdAkyMDA1LTA0LTEyIDE0OjMxOjM4LjAwMDAwMDAwMCAr
MDIwMA0KQEAgLTIwLDcgKzIwLDcgQEANCiANCiBoZWxwICgpIHsNCiAJY2F0IDw8X19FTkRfXw0K
LVRoZSBHSVQgc2NyaXB0ZWQgdG9vbGtpdCAgJChjYXQgVkVSU0lPTikNCitUaGUgR0lUIHNjcmlw
dGVkIHRvb2xraXQgICQoZ2l0dmVyc2lvbi5zaCkNCiANCiBVc2FnZTogZ2l0IENPTU1BTkQgW0FS
R10uLi4NCiANCkNPUFlJTkc6ICBmZTJhNDE3N2E3NjBmZDExMGU3ODc4ODczNGYxNjdiZDYzM2Jl
OGRlIDMzDQpNYWtlZmlsZTogIGI1MTRkYzVjYzYyYmM5ZDJiMmNmMGY4MWRjY2UxNWZmN2RlODNl
ZWUgMzMNClJFQURNRTogIGZhOWI2NzZkNjJmOGFjNWMxZmYzNmU3NzQyZGM2ZGI4ZjZjZGY5N2Yg
MzMNClZFUlNJT046ICBkNzFmOGVhODc1ZjlmYmQ4NmRlN2IxNDU3OTI0NDkyNDczY2QxNzE4IDMz
DQpjYWNoZS5oOiAgZDNlOWEyMWI3ZDlhMmFjMzJhYmFjZjVjYzQwZWUxYTRkODNmOWZlOCAzMw0K
Y2F0LWZpbGUuYzogIDQ1YmUxYmFkYWE4NTE3ZDRlM2E2OWUwYmYxY2FjMmU5MDE5MWU0NzUgMzcN
CmNoZWNrb3V0LWNhY2hlLmM6ICBhODdiMzFlMzc4N2MzMTIzNjRkNzI5NWI3ODJkNmMyMmQxNTc3
ZjVjIDMzDQpjb21taXQtaWQ6ICA2NWM4MTc1NmM4ZjEwZDUxM2QwNzNlY2JkNzQxYTMyNDQ2NjNj
NGM5IDNiDQpjb21taXQtdHJlZS5jOiAgMmUyNWY3MmRkYjY2YmQ4ZWJkNDQ4NDA1ZjZkZjc2ZTE1
Y2M5ZDAzMCAzMw0KZGlmZi10cmVlLmM6ICAzMTczMzlmYzljMTE2OWI4ODZmZGZjMjI4NjNlOTQ1
MTEwOWI4OGM3IDMzDQpmc2NrLWNhY2hlLmM6ICA3YTJmMzZhYTBiYzg2NzdhZGZiYzg1NDIzMzhl
MTZkNTE4OGRlZTRhIDMzDQpnaXQ6ICAyZjFjYzdmODAwNzliOWMyZmVlYzhlNzMxMGQzMGU1N2I2
ZTRiMmFhIDMzDQpnaXRYbm9ybWlkLnNoOiAgNjE5YTg5ODc1YzRjY2Q2ZjM4MGM0YmUzMzI3NGE3
MWJiMmExYjdmMiAzMw0KZ2l0YWRkLnNoOiAgM2VkOTNlYTBmY2I5OTU2NzNiYTllZTE5ODJlMGU3
YWJkYmUzNTk4MiAzMw0KZ2l0YWRkcmVtb3RlLnNoOiAgYWIwNzU2MjhiMGI0YjE2YWEwNTM4Mjk1
NWI4NjA3NzAwZjk2MTAxZiAzMw0KZ2l0Y29tbWl0LnNoOiAgNWU5OGUzYjVmZTUwMWExOTZhMTAz
MGMxMWQxYWQ2YWM4NzUzMmU2YSAzMw0KZ2l0ZGlmZi1kbzogIGQ2MTc0YWJjZWFiMzRkMjIwMTBj
MzZhODQ1M2E2YzNmM2YxODRmZTAgMzMNCmdpdGRpZmYuc2g6ICA5ZjU1ODQyMjAwMzE2MGYwZDAw
NmY3OTQ4NzAyZTIyZDVjOTAyNTRjIDMzDQpnaXRsb2cuc2g6ICBkNmIzM2ZiMGM0NzM2OWJlN2I2
YWYzYjIxZjIxODhlMjI2YmYyZmViIDMzDQpnaXRscy5zaDogIGI2ZjE1ZDgyZjE2YzFlOTk4MmM1
MDMxZjNiZTIyZWI1NDMwMjczYWYgMzMNCmdpdGxzb2JqLnNoOiAgMTI4NDYxZDNkZTZhNDJjZmFh
YTk4OWZjNjQwMWJlYmRmYTg4NWIzZiAzMw0KZ2l0bWVyZ2Uuc2g6ICBlMjVkNDJkZGU3YzliOTI5
NDc2YjA5NjdiMmE2MGQ5YjM0MmIyZTc5IDNiDQpnaXRwdWxsLnNoOiAgZjI5YmIzN2M1ZWVmNDE2
ZWQ2NWU0NmFhM2M1MjQ5M2QwNzYxOWNkOCAzMw0KZ2l0cm0uc2g6ICA1YzE4YzM4YTg5MGM5ZmQ5
YWQyYjg2NmVlN2I1Mjk1MzlkMmYzZjhmIDMzDQpnaXR0YWcuc2g6ICAwY2QzMTg4YTQ0MmEzNjdk
YjMyN2Y3MGFiYTE0ZmYyYTBkNjllOTI3IDNiDQpnaXR0cmFjay5zaDogIGFlMzRmNWM1ZTFlOTk2
OTYxOWRkZThkMDYyMWZkOWMyMTIyMDg2OTQgMzMNCmluaXQtZGIuYzogIDMyOTY3NjNjZGI0YmQy
NDJhOWVjMDE5MzNhYzhkM2Q1MzIwZDIwZTQgMzMNCmxzLXRyZWUuYzogIDNlMmE2YzdkMTgzYTQy
ZTQxZjEwNzNkZmVjNjc5NGU4ZjhhNWU3NWMgMzcNCnBhcmVudC1pZDogIDE4MDFjNmZlNDI2NTky
ODMyZTcyNTBmOGI3NjBmYjlkMmU2NTIyMGYgMzMNCnJlYWQtY2FjaGUuYzogIDk1ZDBlYzZlOTVh
YjA1NGRhNGVmOTY3MzY0MWM5ZjgwOWVlYmVmMmIgMzMNCnJlYWQtdHJlZS5jOiAgZWI1NDgxNDhh
YTZkMjEyZjA1YzJjNjIyZmZiZTYyYTA2Y2QwNzJmOSAzMw0KcmV2LXRyZWUuYzogIDc0MjliOWM0
ZDBhYWIyZTRhNDk0ZWI0YjY1MTI5YTU5ZGExMzgxMDYgMzMNCnNob3ctZGlmZi5jOiAgMDQzNzcy
Y2IwOGI2Nzk1MDA4NDc0MzE2ZjM4YTMyNmM0MTk2ZWRkNiAzNw0Kc2hvdy1maWxlcy5jOiAgMzQ3
ODk0ZDYzNjBlNWVmNTYxNDBhOWE3MGQyYTBiMDAwYTI2OGEzMyAzMw0KdHJlZS1pZDogIGNiNzBl
MmM1MDhhMTgxMDdhYmUzMDU2MzM2MTJlZDcwMmFhM2VlNGYgMzcNCnVwZGF0ZS1jYWNoZS5jOiAg
M2Q0OWExY2JkMjBjN2ZjZjEwMTBiMGYzYWZmYWY4OTYzMTBjNjc5NyAzMw0Kd3JpdGUtdHJlZS5j
OiAgZWVkN2MwMjEyM2M2YzY0NTg1OTc3MjZlZjRmOGIyMjA4YWVmYTViYiAzMw0K


--=-1QMEKeKIFwk3bFajyYb1--

--=-227+5hi1VghJuAPrO6PH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCW8NcqburzKaJYLYRAqiiAJ9boBmYGmsoVOPY0id9MTeDtP9FqQCdE5FC
TC3D0Y3K71r797q98MYc+RE=
=bAmb
-----END PGP SIGNATURE-----

--=-227+5hi1VghJuAPrO6PH--

