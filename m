Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131637AbRAKLtI>; Thu, 11 Jan 2001 06:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbRAKLs7>; Thu, 11 Jan 2001 06:48:59 -0500
Received: from mr14.vic-remote.bigpond.net.au ([24.192.1.29]:55530 "EHLO
	mr14.vic-remote.bigpond.net.au") by vger.kernel.org with ESMTP
	id <S131637AbRAKLsw>; Thu, 11 Jan 2001 06:48:52 -0500
Message-ID: <001801c07bc4$e95ee250$0201a8c0@vaio>
From: "Robert Lowery" <cangela@bigpond.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: ACPI lockup on boot in 2.4.0
Date: Thu, 11 Jan 2001 22:51:59 +1100
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0015_01C07C21.1B4CB1F0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0015_01C07C21.1B4CB1F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a Sony VAIO C1XE (Picturebook) that is giving me some grief with =
2.4.0.

I compiled it with ACPI compiled as a module and APM not compiled in at =
all, but on booting I get the following.
ACPI: System description tables found
ACPI: System description tables loaded

and then the system locks up..

I will try compiling up a kernel without ACPI support and see where I =
get, but any help in the meantime would be appreciated.  I am happy to =
provide any additional information that might be required

-Robert


------=_NextPart_000_0015_01C07C21.1B4CB1F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4611.1300" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a Sony VAIO C1XE (Picturebook) =
that is=20
giving me some grief with 2.4.0.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I compiled it with ACPI compiled as a =
module and=20
APM not compiled in at all, but on booting I get the =
following.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ACPI: System description tables =
found</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>ACPI: System description tables =
loaded</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>and then the&nbsp;system locks =
up..</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I will try compiling up a kernel =
without ACPI=20
support and see where I get, but any help in the meantime would be=20
appreciated.&nbsp; I am happy to provide any additional information that =
might=20
be required</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>-Robert</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0015_01C07C21.1B4CB1F0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
