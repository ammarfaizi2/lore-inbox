Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310627AbSBROSv>; Mon, 18 Feb 2002 09:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310630AbSBROSl>; Mon, 18 Feb 2002 09:18:41 -0500
Received: from dsl254-096-012.nyc1.dsl.speakeasy.net ([216.254.96.12]:35950
	"EHLO mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id <S310627AbSBROSZ>; Mon, 18 Feb 2002 09:18:25 -0500
content-class: urn:content-classes:message
Subject: SCSI black lists
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C1B887.1D94D190"
Date: Mon, 18 Feb 2002 09:18:19 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB0C4CF0@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] queue barrier support 
Thread-Index: AcG2+0q5PDYaya/9TQu8qs4bo65PSQBi2jcA
From: "Heinz, Michael" <mheinz@infiniconsys.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C1B887.1D94D190
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I would argue that making the black list configurable a very important
addition. It would certainly make life easier for administrators if they
could add SAN devices without worrying about whether or not the kernel
already knows they have special characteristics.

> Well, following the current SCSI black/white list procedure,=20
> they would be in=20
> the static device_list table in scsi_scan.c, so no.
>=20

------_=_NextPart_001_01C1B887.1D94D190
Content-Type: text/x-vcard;
	name="Heinz, Michael.vcf"
Content-Transfer-Encoding: base64
Content-Description: Heinz, Michael.vcf
Content-Disposition: attachment;
	filename="Heinz, Michael.vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpOOkhlaW56O01pY2hhZWwNCkZOOkhlaW56LCBNaWNo
YWVsDQpFTUFJTDtQUkVGO0lOVEVSTkVUOm1oZWluekBpbmZpbmljb25zeXMuY29tDQpSRVY6MjAw
MTA3MTFUMTkxNTM1Wg0KRU5EOlZDQVJEDQo=

------_=_NextPart_001_01C1B887.1D94D190--
