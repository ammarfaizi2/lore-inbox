Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129215AbQKGLdx>; Tue, 7 Nov 2000 06:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129505AbQKGLdo>; Tue, 7 Nov 2000 06:33:44 -0500
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:8521 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S129215AbQKGLdg>; Tue, 7 Nov 2000 06:33:36 -0500
Message-ID: <000001c048ae$6132c340$6904883e@default>
From: "Joe Woodward" <woodey@twasystems.fsnet.co.uk>
To: <linux-kernel@vger.kernel.org>
Subject: removable EIDE disks
Date: Tue, 7 Nov 2000 11:12:00 -0000
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C048AB.8CFEF320"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C048AB.8CFEF320
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I am trying to use removable EIDE hard disks on a Red Hat Linux 6.1 =
machine, for backup / walknet purposes.

Issuing a BLKRRPART ioctl call immediately after changing the disk =
works, but only if the new disk is no larger than the disk present at =
boot time (smaller and equal capacity disks work OK).

How do I get Linux to recognise that the media in /dev/hdc has changed?

Bill Nottingham suggested that I ask you, as he is unsure if this is a =
bug or if there is a technique that I am missing.


Thanks

Richard Stanton

rich@twasystems.fsnet.co.uk


------=_NextPart_000_0005_01C048AB.8CFEF320
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2919.6307" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT color=3D#000000 size=3D2>I am trying to use removable EIDE =
hard disks on=20
a Red Hat Linux 6.1 machine, for backup / walknet purposes.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2>Issuing a BLKRRPART ioctl call =
immediately after=20
changing the disk works, but only if the new disk is no larger than the =
disk=20
present at boot time (smaller and equal capacity disks work =
OK).</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2>How do I get Linux to recognise that =
the media=20
in /dev/hdc has changed?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2>Bill Nottingham suggested that I ask =
you, as he=20
is unsure if this is a bug or if there is a technique that I am=20
missing.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2>Thanks</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2>Richard Stanton</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT color=3D#000000 size=3D2><A=20
href=3D"mailto:rich@twasystems.fsnet.co.uk">rich@twasystems.fsnet.co.uk</=
A></FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0005_01C048AB.8CFEF320--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
