Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275458AbTHJBoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 21:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275459AbTHJBoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 21:44:13 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:64498 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S275458AbTHJBoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 21:44:07 -0400
Subject: [2.6.0-test3] Firmware loader support config fix
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9n5zW+RbAP9TkAxTAl7R"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1060479842.8303.5.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 10 Aug 2003 03:44:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9n5zW+RbAP9TkAxTAl7R
Content-Type: multipart/mixed; boundary="=-a614bGwSC+xPt/ql01zA"


--=-a614bGwSC+xPt/ql01zA
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi.

Fix the config issue with the hotplug firmware loader. The firmware
loader use hotplug, so this must be included as a dependency.
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

--=-a614bGwSC+xPt/ql01zA
Content-Description: 
Content-Disposition: inline; filename=fw_loader_dep_hotplug.diff
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: base64

PT09PT0gS2NvbmZpZyAxLjMgdnMgZWRpdGVkID09PT09DQotLS0gMS4zL2RyaXZlcnMvYmFzZS9L
Y29uZmlnCVRodSBKdW4gMTkgMTk6MDY6NTYgMjAwMw0KKysrIGVkaXRlZC9LY29uZmlnCVN1biBB
dWcgMTAgMDM6MzY6MTkgMjAwMw0KQEAgLTIsNiArMiw3IEBADQogDQogY29uZmlnIEZXX0xPQURF
Ug0KIAl0cmlzdGF0ZSAiSG90cGx1ZyBmaXJtd2FyZSBsb2FkaW5nIHN1cHBvcnQiDQorCWRlcGVu
ZHMgb24gSE9UUExVRw0KIAktLS1oZWxwLS0tDQogCSAgVGhpcyBvcHRpb24gaXMgcHJvdmlkZWQg
Zm9yIHRoZSBjYXNlIHdoZXJlIG5vIGluLWtlcm5lbC10cmVlIG1vZHVsZXMNCiAJICByZXF1aXJl
IGhvdHBsdWcgZmlybXdhcmUgbG9hZGluZyBzdXBwb3J0LCBidXQgYSBtb2R1bGUgYnVpbHQgb3V0
c2lkZQ0K

--=-a614bGwSC+xPt/ql01zA--

--=-9n5zW+RbAP9TkAxTAl7R
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/NaNiRGk68b69cdURAkvYAJ9jUPtVK2acqBAv+8xkXt2wqO8cpQCfefVP
m3yyRyGAotkxzypxQMs8ieU=
=/Sj+
-----END PGP SIGNATURE-----

--=-9n5zW+RbAP9TkAxTAl7R--

