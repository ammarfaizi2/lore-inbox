Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312515AbSCYTRR>; Mon, 25 Mar 2002 14:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312516AbSCYTRH>; Mon, 25 Mar 2002 14:17:07 -0500
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:58599 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id <S312515AbSCYTQv>; Mon, 25 Mar 2002 14:16:51 -0500
Date: Mon, 25 Mar 2002 20:07:21 +0100 (CET)
From: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
To: Greg KH <greg@kroah.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: USB Microsoft Natural KeyB not recogniced as a HID device
In-Reply-To: <20020325183011.GA29011@kroah.com>
Message-ID: <Pine.LNX.4.30.0203251957590.5375-200000@stud.fbi.fh-darmstadt.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1686978856-797851508-1017083241=:5375"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1686978856-797851508-1017083241=:5375
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi Greg

[schnipp]
> Can you try the patches at:
>       http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101684196109355
> and also:
>       http://marc.theaimsgroup.com/?l=linux-usb-devel&m=101684207509482
>
> And let us know if they help you out?
[schnapp]

Applied both patches - the keyboard is detected again, but I still have
some errors in the lsusb-output (see attachment).

Anyway the keyboard works.

Thanks

Jan-Marek

--1686978856-797851508-1017083241=:5375
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="usb-2.4.18-rc2-ac1--2.4.19-pre3-ac6-patched.log"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0203252007210.5375@stud.fbi.fh-darmstadt.de>
Content-Description: 
Content-Disposition: attachment; filename="usb-2.4.18-rc2-ac1--2.4.19-pre3-ac6-patched.log"

LS0tIHVzYi0yLjQuMTgtcmMyLWFjMS5sb2cJU3VuIE1hciAyNCAxNzo0ODox
OCAyMDAyDQorKysgdXNiLTIuNC4xOS1wcmUzLWFjNi1wYXRjaGVkLmxvZwlN
b24gTWFyIDI1IDIwOjA4OjI0IDIwMDINCkBAIC0xMjksNyArMTI5LDkgQEAN
CiAgICAgICBiSW50ZXJmYWNlTnVtYmVyICAgICAgICAwDQogICAgICAgYkFs
dGVybmF0ZVNldHRpbmcgICAgICAgMA0KICAgICAgIGJOdW1FbmRwb2ludHMg
ICAgICAgICAgIDENCi0gICAgICBiSW50ZXJmYWNlQ2xhc3MgICAgICAgICA5
IEh1Yg0KKyAgICAgIGJJbnRlcmZhY2VDbGFzcyBjYW5ub3QgZ2V0IHN0cmlu
ZyBkZXNjcmlwdG9yIDEsIGVycm9yID0gQnJva2VuIHBpcGUoMzIpDQorY2Fu
bm90IGdldCBzdHJpbmcgZGVzY3JpcHRvciAyLCBlcnJvciA9IEJyb2tlbiBw
aXBlKDMyKQ0KKyAgICAgICAgOSBIdWINCiAgICAgICBiSW50ZXJmYWNlU3Vi
Q2xhc3MgICAgICAwIA0KICAgICAgIGJJbnRlcmZhY2VQcm90b2NvbCAgICAg
IDAgDQogICAgICAgaUludGVyZmFjZSAgICAgICAgICAgICAgMCANCkBAIC0y
NTQsNyArMjU2LDEwIEBADQogICAgICAgICBiRW5kcG9pbnRBZGRyZXNzICAg
ICAweDgxICBFUCAxIElODQogICAgICAgICBibUF0dHJpYnV0ZXMgICAgICAg
ICAgICAzDQogICAgICAgICAgIFRyYW5zZmVyIFR5cGUgICAgICAgICAgICBJ
bnRlcnJ1cHQNCi0gICAgICAgICAgU3luY2ggVHlwZSAgICAgICAgICAgICAg
IG5vbmUNCisgICAgICAgICAgU3luY2ggVHlwZSAgICAgICAgICAgICBjYW5u
b3QgZ2V0IHN0cmluZyBkZXNjcmlwdG9yIDEsIGVycm9yID0gQnJva2VuIHBp
cGUoMzIpDQorY2Fubm90IGdldCBzdHJpbmcgZGVzY3JpcHRvciAxLCBlcnJv
ciA9IEJyb2tlbiBwaXBlKDMyKQ0KK2Nhbm5vdCBnZXQgc3RyaW5nIGRlc2Ny
aXB0b3IgMSwgZXJyb3IgPSBCcm9rZW4gcGlwZSgzMikNCisgIG5vbmUNCiAg
ICAgICAgIHdNYXhQYWNrZXRTaXplICAgICAgICAgIDENCiAgICAgICAgIGJJ
bnRlcnZhbCAgICAgICAgICAgICAyNTUNCiAgIExhbmd1YWdlIElEczogbm9u
ZSAoY2Fubm90IGdldCBtaW4uIHN0cmluZyBkZXNjcmlwdG9yOyBnb3QgbGVu
PS0xLCBlcnJvcj0zMjpCcm9rZW4gcGlwZSkNCg==
--1686978856-797851508-1017083241=:5375--
