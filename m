Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288978AbSAZB0h>; Fri, 25 Jan 2002 20:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288975AbSAZB02>; Fri, 25 Jan 2002 20:26:28 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:58244 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S288978AbSAZB0L>; Fri, 25 Jan 2002 20:26:11 -0500
Date: Sat, 26 Jan 2002 04:25:56 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: miles@megapathdsl.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre5 -- "pcilynx.c:638: invalid operands to binary &"  and  "pcilynx.c:650: `cards' undeclared"
Message-Id: <20020126042556.355c7cc8.johnpol@2ka.mipt.ru>
In-Reply-To: <20020126042049.125616e0.johnpol@2ka.mipt.ru>
In-Reply-To: <1011932306.18088.162.camel@stomata.megapathdsl.net>
	<20020125123711.0f0ebc61.johnpol@2ka.mipt.ru>
	<1011979851.1261.9.camel@stomata.megapathdsl.net>
	<20020126042049.125616e0.johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__26_Jan_2002_04:25:56_+0300_083a9458"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__26_Jan_2002_04:25:56_+0300_083a9458
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Ooops, forgot to attach apatch, sorry.

> I hope this patch will hel you.
> Please apply and send feedback.
> Good luck.
> BTW, it probably won't work in 644 string, and if it will happen, than
> Dave Jones tree is also broken.
> 
> P.S. It will not probably be applied, so enter
> ./drivers/ieee1394/pcilynx.c by hands. Sorry.

> > Thanks,
> > 	Miles

	Evgeniy Polyakov ( s0mbre ).

--Multipart_Sat__26_Jan_2002_04:25:56_+0300_083a9458
Content-Type: application/octet-stream;
 name="ieee1394_pcilynx.patch"
Content-Disposition: attachment;
 filename="ieee1394_pcilynx.patch"
Content-Transfer-Encoding: base64

LS0tIC90bXAvcGNpbHlueC5jCVNhdCBKYW4gMjYgMDQ6MTA6MzkgMjAwMgorKysgLi9kcml2ZXJz
L2llZWUxMzk0L3BjaWx5bnguYwlTYXQgSmFuIDI2IDA0OjE1OjQzIDIwMDIKQEAgLTY0MSw3ICs2
NDEsNyBAQAogCiBzdGF0aWMgaW50IG1lbV9vcGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVj
dCBmaWxlICpmaWxlKQogewotICAgICAgICBpbnQgY2lkID0gTUlOT1IoaW5vZGUtPmlfcmRldik7
CisgICAgICAgIGludCBjaWQgPSBtaW5vcihpbm9kZS0+aV9yZGV2KTsKICAgICAgICAgZW51bSB7
IHRfcm9tLCB0X2F1eCwgdF9yYW0gfSB0eXBlOwogICAgICAgICBzdHJ1Y3QgbWVtZGF0YSAqbWQ7
CiAgICAgICAgIApAQCAtMTUxNyw3ICsxNTE3LDcgQEAKICAgICAgICAgbHlueC0+c3RhdGUgPSBp
c19ob3N0OwogCQogCWlmIChudW1fb2ZfY2FyZHMgPCBNQVhfTlVNX09GX0NBUkRTKQotCQljYXJk
c1tudW1fb2ZfY2FyZHMrK10gPSBob3N0LT5ob3N0ZGF0YTsKKwkJY2FyZHNbbnVtX29mX2NhcmRz
KytdID0gKihob3N0LT5ob3N0ZGF0YSk7CiAJZWxzZQogCQlGQUlMKCJUb28gbWFueSBjYXJkc1sg
JWQgXS4uLiBJbXBvc3NpYmxlLi4uXG4iLCBudW1fb2ZfY2FyZHMpOwogCg==

--Multipart_Sat__26_Jan_2002_04:25:56_+0300_083a9458--
