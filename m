Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSLGSxZ>; Sat, 7 Dec 2002 13:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264677AbSLGSxZ>; Sat, 7 Dec 2002 13:53:25 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:3218 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S264673AbSLGSxY>; Sat, 7 Dec 2002 13:53:24 -0500
Date: Sat, 7 Dec 2002 14:01:07 -0500 (EST)
From: Nathaniel Russell <root@chartermi.net>
X-X-Sender: root@reddog.example.net
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
cc: reddog83@chartermi.net, <linux-kernel@vger.kernel.org>, <davej@suse.de>
Subject: Re: [PATCH 2.5.x] Via AGP Support
In-Reply-To: <200212071055.17560.ruth@ivimey.org>
Message-ID: <Pine.LNX.4.44.0212071341470.1168-200000@reddog.example.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1267532229-1039287667=:1168"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1267532229-1039287667=:1168
Content-Type: TEXT/PLAIN; charset=US-ASCII

I was so tired last night I forgot to dot the i's and cross my t's.
Well here is the patch with the missing 'E' in it. ;)
Nathaniel
CC me at reddog83@chartermi.net

On Sat, 7 Dec 2002, Ruth Ivimey-Cook wrote:

> On Saturday 07 December 2002 10:41, Nathaniel Russell wrote:
> > This patch add's support for the Via 8633 AGP Card Slot.
>
> > +               .device_id      = PCI_DEVICE_ID_VIA_8633_0,
> > +               .vendor_id      = PCI_VENDOR_ID_VIA,
> > +               .chipset        = VIA_GENRIC,
>
> Missing 'E' in Generic ^^^
>
> Ruth
>
> --
> Ruth Ivimey-Cook
> Software Engineer and Technical Author.
>

--8323328-1267532229-1039287667=:1168
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="agp.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0212071401070.1168@reddog.example.net>
Content-Description: Updated Via AGP Patch
Content-Disposition: attachment; filename="agp.diff"

ZGlmZiAtdXJOIGxpbnV4LTIuNS9kcml2ZXJzL2NoYXIvYWdwL2FncC5jfiBs
aW51eC9kcml2ZXJzL2NoYXIvYWdwL2FncC5jDQotLS0gbGludXgtMi41L2Ry
aXZlcnMvY2hhci9hZ3AvYWdwLmN+CTIwMDItMTItMDUgMTM6NDQ6MTkuMDAw
MDAwMDAwIC0wNTAwDQorKysgbGludXgvZHJpdmVycy9jaGFyL2FncC9hZ3Au
YwkyMDAyLTEyLTA3IDA1OjM2OjEyLjAwMDAwMDAwMCAtMDUwMA0KQEAgLTEx
NjYsNiArMTE2NiwxNCBAQA0KIAkJLmNoaXBzZXRfc2V0dXAJPSB2aWFfZ2Vu
ZXJpY19zZXR1cA0KIAl9LA0KIAl7DQorCQkuZGV2aWNlX2lkCT0gUENJX0RF
VklDRV9JRF9WSUFfODYzM18wLA0KKwkJLnZlbmRvcl9pZAk9IFBDSV9WRU5E
T1JfSURfVklBLA0KKwkJLmNoaXBzZXQJPSBWSUFfR0VORVJJQywNCisJCS52
ZW5kb3JfbmFtZQk9ICJWaWEiLA0KKwkJLmNoaXBzZXRfbmFtZQk9ICI4NjMz
IiwNCisJCS5jaGlwc2V0X3NldHVwCT0gdmlhX2dlbmVyaWNfc2V0dXANCisJ
fSwNCisJew0KIAkJLmRldmljZV9pZAk9IDAsDQogCQkudmVuZG9yX2lkCT0g
UENJX1ZFTkRPUl9JRF9WSUEsDQogCQkuY2hpcHNldAk9IFZJQV9HRU5FUklD
LA0K
--8323328-1267532229-1039287667=:1168--
