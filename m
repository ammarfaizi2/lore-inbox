Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRAJQts>; Wed, 10 Jan 2001 11:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbRAJQtj>; Wed, 10 Jan 2001 11:49:39 -0500
Received: from cannet.com ([206.156.188.2]:24841 "HELO mail.cannet.com")
	by vger.kernel.org with SMTP id <S130873AbRAJQt1>;
	Wed, 10 Jan 2001 11:49:27 -0500
Message-ID: <007801c07b25$1695db20$7930000a@hcd.net>
From: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.2.18 reboots on high load.
Date: Wed, 10 Jan 2001 11:47:58 -0500
Organization: Himebaugh Consulting, Inc.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0075_01C07AFB.2D8D7880"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0075_01C07AFB.2D8D7880
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a 2.2.18 (with reiserfs patch), running on a Pentium 100

any time I get high disk writes or reads my system just reboots.
I have had it up and running with moderate disk activity (telnet
and small FTP's) for a week; however, when I write alot to the=20
disk (100 Mb plus), the system just reboots.  I am also getting
kernel panics around every 3-4 times.  I tried writing to the disk
with Samba, and fith FTP.  I am running proFTP.  Please tell me
what I need to send you.  I will not that /proc/cpuinfo tells me that
my processor has a f00f bug?

The system is as follows.

Intel Pentium 100
32 Mb Ram
1Gb root partition - 32 Mb swap
14 Gb reiserfs partition

I am running Samba 2.0.7 and Apache 1.3.14 (with mod-ssl).

------=_NextPart_000_0075_01C07AFB.2D8D7880
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dwindows-1252" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.3211.1700" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a 2.2.18 (with reiserfs patch), =
running on a=20
Pentium 100</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>any time I get high disk writes or =
reads my system=20
just reboots.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I have had it up and running with =
moderate disk=20
activity (telnet</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and small FTP's) for a week; however, =
when I write=20
alot to the </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>disk (100 Mb plus), the system just =
reboots.&nbsp;=20
I am also getting</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>kernel panics around every 3-4 =
times.&nbsp; I tried=20
writing to the disk</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>with Samba, and fith FTP.&nbsp; I am =
running=20
proFTP.&nbsp; Please tell me</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>what I need to send you.&nbsp; I will =
not that=20
/proc/cpuinfo tells me that</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>my processor has a f00f =
bug?</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The system is as follows.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Intel Pentium 100</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>32 Mb Ram</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>1Gb root partition - 32 Mb =
swap</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>14 Gb reiserfs partition</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am running Samba 2.0.7 and Apache =
1.3.14 (with=20
mod-ssl).</FONT></DIV></BODY></HTML>

------=_NextPart_000_0075_01C07AFB.2D8D7880--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
