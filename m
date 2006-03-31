Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWCaHwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWCaHwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWCaHwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:52:12 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:31183 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751079AbWCaHwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:52:11 -0500
Date: Fri, 31 Mar 2006 09:52:36 +0200
From: Bertrand Jacquin <beber@gna.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: beber.lkml@gmail.com, gregkh@suse.de, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] isd200: limit to BLK_DEV_IDE
Message-Id: <20060331095236.72e5ab52.beber@gna.org>
In-Reply-To: <Pine.LNX.4.58.0603301431560.26598@shark.he.net>
References: <20060328075629.GA8083@kroah.com>
	<4615f4910603301146x5496ccaai17bf5f4636c91c45@mail.gmail.com>
	<Pine.LNX.4.58.0603301431560.26598@shark.he.net>
Organization: GMail
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.13; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__31_Mar_2006_09_52_36_+0200_zn4t0pohQTckYBVU"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__31_Mar_2006_09_52_36_+0200_zn4t0pohQTckYBVU
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: base64

TGUgVGh1LCAzMCBNYXIgMjAwNiAxNDozNToyNiAtMDgwMCAoUFNUKSwgIlJhbmR5LkR1bmxhcCIg
PHJkdW5sYXBAeGVub3RpbWUubmV0PiBtJ2EgYXZvdcOpOg0KDQo+IE9uIFRodSwgMzAgTWFyIDIw
MDYsIEJlYmVyIHdyb3RlOg0KPiANCj4gPiBPbiAzLzI4LzA2LCBHcmVnIEtIIDxncmVna2hAc3Vz
ZS5kZT4gd3JvdGU6DQo+ID4gPiBXZSAodGhlIC1zdGFibGUgdGVhbSkgYXJlIGFubm91bmNpbmcg
dGhlIHJlbGVhc2Ugb2YgdGhlIDIuNi4xNi4xIGtlcm5lbC4NCj4gPg0KPiA+IEkgc3RpbGwgZ2V0
IHRoaXMgZXJyb3IgOg0KPiA+DQo+ID4gIyBtYWtlDQo+IC4uLg0KPiA+IGRyaXZlcnMvYnVpbHQt
aW4ubzogSW4gZnVuY3Rpb24gYGlzZDIwMF9Jbml0aWFsaXphdGlvbic6DQo+ID4gOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBpZGVfZml4X2RyaXZlaWQnDQo+ID4gbWFrZTogKioqIFsudG1wX3Zt
bGludXgxXSBFcnJvciAxDQo+IA0KPiBXYXMgdGhpcyByZXBvcnRlZCBlYXJsaWVyPw0KDQpZZXMs
IGl0IHdhcywgYnV0IGlnbm9yZWQsIHNvIEkgcmVwb3N0IGl0IDspDQoNCj4gUGxlYXNlIHRlc3Qg
dGhlIHBhdGNoIGJlbG93Lg0KPiBJdCB3b3JrcyBmb3IgbWUgd2l0aCB5b3VyIGNvbmZpZyBhbmQg
dmFyaW91cyBvdGhlcnMuDQoNCkl0IHdvcmsgaGVyZSB0b28uDQpUaGFua3MNCg0KLS0gDQovKiBC
ZWJlciA6IGJlYmVyIChBVCkgZ25hIChET1QpIG9yZw0KICogaHR0cDovL2d1eWJydXNoLmF0aC5j
eCwgaXJjOi8vaXJjLmZyZWVub2RlLm5ldC8je2UuZnIsZ2VudG9vZnJ9DQogKiBHdXlicnVzaCBA
IE1lbGVlICovDQo=

--Signature=_Fri__31_Mar_2006_09_52_36_+0200_zn4t0pohQTckYBVU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFELN/HOoDxkpMsDusRAv8+AJ9vNyHss8qAh6ep0qYAmd67y+CIWgCguwk1
UhEYHmAmiP99g4cUcsSoLyA=
=dw32
-----END PGP SIGNATURE-----

--Signature=_Fri__31_Mar_2006_09_52_36_+0200_zn4t0pohQTckYBVU--
