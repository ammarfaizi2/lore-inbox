Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131496AbQLVBFE>; Thu, 21 Dec 2000 20:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131603AbQLVBEq>; Thu, 21 Dec 2000 20:04:46 -0500
Received: from NS2.pcscs.com ([207.96.110.42]:49417 "EHLO linux01.pcscs.com")
	by vger.kernel.org with ESMTP id <S131496AbQLVBEd>;
	Thu, 21 Dec 2000 20:04:33 -0500
Message-ID: <009501c06bae$e24c32e0$2b6e60cf@pcscs.com>
From: "Charles Wilkins" <chas@pcscs.com>
To: "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: max number of ide controllers?
Date: Thu, 21 Dec 2000 19:34:03 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0092_01C06B84.F9656200"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0092_01C06B84.F9656200
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have been running with the 2 onboard VIA ide hd controllers (ide 0 and =
ide 1) along with a creative labs ide contoller on a SB32 soundcard (ide =
3). This has had the cdrom and zip drive.

I just added a Promise Ultra100 and it has assumed the role of ide 3 and =
ide 4. The onboard controllers are still ide 0 and ide 1, but the =
creative labs controller isnt coming up.

Is there a max number of ide controllers that linux-2.2.18 can support?

------=_NextPart_000_0092_01C06B84.F9656200
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
<DIV><FONT face=3DArial size=3D2>I have been running with the 2 onboard =
VIA ide hd=20
controllers (ide 0 and ide 1) along with a creative labs ide contoller =
on a SB32=20
soundcard (ide 3). This has had the cdrom and zip drive.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I just added a Promise Ultra100 and it =
has assumed=20
the role of ide 3 and ide 4. The onboard controllers are still ide 0 and =
ide 1,=20
but the creative labs controller isnt coming up.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Is there a max number of ide =
controllers that=20
linux-2.2.18 can support?</FONT></DIV></BODY></HTML>

------=_NextPart_000_0092_01C06B84.F9656200--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
