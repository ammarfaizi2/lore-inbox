Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131055AbQLMSpD>; Wed, 13 Dec 2000 13:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131258AbQLMSox>; Wed, 13 Dec 2000 13:44:53 -0500
Received: from ns1.advansys.com ([204.247.22.3]:21774 "EHLO
	main.connectcom.net") by vger.kernel.org with ESMTP
	id <S131055AbQLMSoj>; Wed, 13 Dec 2000 13:44:39 -0500
Message-ID: <31AA01741B3FD311BF7A005004D171A95DB163@main.connectcom.net>
From: Andy Kellner <Akellner@connectcom.net>
To: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12: request_module[scsi_hostadapter]: Root fs not mount
	ed 
Date: Wed, 13 Dec 2000 10:13:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C06530.5DD07FAE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C06530.5DD07FAE
Content-Type: text/plain;
	charset="iso-8859-1"

Hello,

I get the following error during boot with 2.4.0-test12:

SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted

SCSI, SCSI disc and SCSI generic support compiled in. SCSI driver compiled
as module.
The same configuration was working fine with 2.2.16/.18. I get the same
error with and without using initrd.
I browsed the FAQ's and archives of this list and noticed that this issue
poped up a while ago, but never came
to a conclusion ? Any hints ?

Thanks,

Andy

------_=_NextPart_001_01C06530.5DD07FAE
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2650.12">
<TITLE>2.4.0-test12: request_module[scsi_hostadapter]: Root fs not =
mounted </TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2 FACE=3D"Arial">Hello,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">I get the following error during boot =
with 2.4.0-test12:</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Courier New">SCSI subsystem driver Revision: =
1.00</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">request_module[scsi_hostadapter]: =
Root fs not mounted</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">SCSI, SCSI disc and SCSI generic =
support compiled in. SCSI driver compiled as module.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">The same configuration was working =
fine with 2.2.16/.18. I get the same error with and without using =
initrd.</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">I browsed the FAQ's and archives of =
this list and noticed that this issue poped up a while ago, but never =
came</FONT>
<BR><FONT SIZE=3D2 FACE=3D"Arial">to a conclusion ? Any hints ?</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Thanks,</FONT>
</P>

<P><FONT SIZE=3D2 FACE=3D"Arial">Andy</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C06530.5DD07FAE--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
