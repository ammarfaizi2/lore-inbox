Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBMS50>; Tue, 13 Feb 2001 13:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRBMS5P>; Tue, 13 Feb 2001 13:57:15 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:41221 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129032AbRBMS5E>; Tue, 13 Feb 2001 13:57:04 -0500
Message-ID: <3A8983FC.C639275C@programmfabrik.de>
Date: Tue, 13 Feb 2001 19:59:08 +0100
From: Martin Rode <Martin.Rode@programmfabrik.de>
Organization: Programmfabrik GmbH
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-9mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG in sched.c, Kernel 2.4.1?
In-Reply-To: <3A8942FA.484BE2FC@programmfabrik.de> <3A8944F1.93C252EB@didntduck.org> <3A895194.89D69AE9@programmfabrik.de> <3A895795.56741320@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------A606A26190BBECDCF68D2B7C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A606A26190BBECDCF68D2B7C
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: base64

TWFuZnJlZCBTcHJhdWwgd3JvdGU6DQoNCj4gTWFydGluIFJvZGUgd3JvdGU6DQo+ID4NCj4g
PiA+DQo+ID4gPiBSdW4gdGhpcyBvb3BzIG1lc3NhZ2UgdGhyb3VnaCBrc3ltb29wcyBwbGVh
c2UuICBJdCB3aWxsIG1ha2UgZGVidWdnaW5nDQo+ID4gPiBpdCBhbG90IGVhc2llci4NCj4g
PiA+DQo+ID4gPg0KPiA+DQo+ID4gU2luY2UgSSBkaWQgbm90IGNvbXBpbGUgdGhlIGtlcm5l
bCBteXNlbGYsIGtzeW1vb3BzIGlzIG5vdCB0b28gaGFwcHkgd2l0aA0KPiA+IHdoYXQgaXMg
aGFzIHRvIGFuYWx5c2UgdGhlIGR1bXAuIEkgdHJpZWQgY29tcGlsZSB0aGUgTWFuZHJha2Ug
a2VybmVsIG15c2VsZg0KPiA+IGJ1dCB0aGVyZSBzZWVtcyB0byBiZSBzb21ldGhpbmcgdW5t
YXRjaGVkLiBTZWUgYmVsb3cgZm9yIHdoYXQga3N5bW9vcHMNCj4gPiBnaXZlcyBtZS4NCj4g
Pg0KPiBsb29rcyBnb29kLg0KPg0KPiA+IGNhbGwgdHJhY2U6IFs8Y2MwMTM5YzQ0Pl0gWzxj
MDEzOWQxYz5dIFs8YzAxMzBhZjY+XSBbPGMwMTA4ZTkzPl0NCj4gICAgICAgICAgICAgICAg
IF5eXl5eXl5eXg0KPg0KDQpJIHJlLXJhbiBrc3ltb29wcyBhbmQgcG9zdGVkIGl0IGFnYWlu
IHRvIHRoZSBsaXN0Lg0KDQo+IElzIHRoYXQgdGhlIGZpcnN0IG9vcHMsIG9yIHdhcyB0aGVy
ZSBhbm90aGVyIG9vcHMgYmVmb3JlIHRoaXMgb25lPw0KDQpJIGRvbid0IGtub3cuIFRoZSBz
ZXJ2ZXIgaXMgaW4gYSBkaWZmZXJlbnQgcm9vbSBmcm9tIG15IG9mZmljZSBzbyBhbGwgSSBz
YXcgd2FzDQp0aGUgbG9jayB1cCBhbmQgYWxsIEkgY291bGQgZG8gd2FzIGNvcHlpbmcgdGhl
IG9vcHMgZnJvbSBzY3JlZW4uIE91ciBiYWNrdXANCnJlZ3VsYXJpbHkgc3RhcnRzIGF0IDkg
UC5NLiwgc28gSSdtIHZlcnkgY29uZmlkZW50IHRoYXQgaXQgJ3MgZ29ubmEgaGFwcGVuDQph
Z2Fpbi4NCg0KSXQgZGlkIG5vdCBoYXBwZW4gd2l0aCAyLjIuMTggb3IgMi4yLjE5cHJlLCB0
aGF0J3MgZm9yIHN1cmUuIFdpdGggdGhlc2Uga2VybmVsIEkNCm9ubHkgaGFkIE1NIHByb2Js
ZW1zIGxpa2Ugdm1fdHJ5aW5nX3RvX2ZyZWVfdW51c2VkX3BhZ2UgZXRjLg0KDQpNYXJ0aW4N
Cg0KDQo=
--------------A606A26190BBECDCF68D2B7C
Content-Type: text/x-vcard; charset=iso-8859-1;
 name="Martin.Rode.vcf"
Content-Transfer-Encoding: base64
Content-Description: Card for Martin Rode
Content-Disposition: attachment;
 filename="Martin.Rode.vcf"

YmVnaW46dmNhcmQgCm46Um9kZTtNYXJ0aW4KdGVsO2NlbGw6KzQ5LTE3MS0xMjU5NTI1CnRl
bDtmYXg6KzQ5LTMwLTQyODEtODAwOAp0ZWw7d29yazorNDktMzAtNDI4MS04MDAxCngtbW96
aWxsYS1odG1sOlRSVUUKdXJsOnd3dy5wcm9ncmFtbWZhYnJpay5kZS9+bWFydGluCm9yZzpQ
cm9ncmFtbWZhYnJpayBHbWJIO0VudHdpY2tsdW5nCmFkcjo7O0ZyYW5rZnVydGVyIEFsbGVl
IDczZDsxMDI0NyBCZXJsaW47OztHZXJtYW55CnZlcnNpb246Mi4xCmVtYWlsO2ludGVybmV0
Ok1hcnRpbi5Sb2RlQHByb2dyYW1tZmFicmlrLmRlCnRpdGxlOkRpcGwuLUtmbS4KeC1tb3pp
bGxhLWNwdDo7LTI4OTYwCmZuOk1hcnRpbiBSb2RlCmVuZDp2Y2FyZAo=
--------------A606A26190BBECDCF68D2B7C--

