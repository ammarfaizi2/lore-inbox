Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131823AbQLPNdl>; Sat, 16 Dec 2000 08:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131865AbQLPNdb>; Sat, 16 Dec 2000 08:33:31 -0500
Received: from NS2.pcscs.com ([207.96.110.42]:53253 "EHLO linux01.pcscs.com")
	by vger.kernel.org with ESMTP id <S131823AbQLPNdU>;
	Sat, 16 Dec 2000 08:33:20 -0500
Message-ID: <008201c06760$7ecd9ee0$2b6e60cf@pcscs.com>
From: "Charles Wilkins" <chas@pcscs.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel software raid support
Date: Sat, 16 Dec 2000 08:02:50 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_007F_01C06736.95EFF5C0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_007F_01C06736.95EFF5C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

What is the status of software raid development in 2.2.x?

There seems to be a growing number of hacks addressing kernel raid =
support, tools, and such specifics as read balancing, yet the kernel =
contains very old code for raid support which seems to act as nothing =
more than a placeholder for patching.=20

Would anybody happen to have a current list of working patches for a =
decent implementation of software raid1 using the 2.2.18 kernel that =
employs some level of read performance that exceeds that of 1 harddisk?

Regards,
Charles

------=_NextPart_000_007F_01C06736.95EFF5C0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3207.2500" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>What is the status of software raid =
development in=20
2.2.x?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>There seems to be a growing number of =
hacks=20
addressing kernel raid support, tools, and&nbsp;such specifics as read=20
balancing, yet the kernel contains very old code for raid support which =
seems to=20
act as nothing more than a placeholder for patching. </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Would anybody happen to have a current =
list of=20
working patches for a decent implementation of software raid1 using the =
2.2.18=20
kernel that employs some level of read performance that exceeds that of =
1=20
harddisk?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial =
size=3D2>Charles</FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_007F_01C06736.95EFF5C0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
