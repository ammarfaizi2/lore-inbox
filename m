Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbQL3Il1>; Sat, 30 Dec 2000 03:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbQL3IlR>; Sat, 30 Dec 2000 03:41:17 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:53141 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S130290AbQL3IlC>; Sat, 30 Dec 2000 03:41:02 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Date: Sat, 30 Dec 2000 03:03:51 -0500
Subject: test13-pre6 compile error..network.o
Message-ID: <20001230.030356.-209335.1.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_7074.230c.49e0
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_7074.230c.49e0
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

Hello,
     I received the following error while compiling test13-pre6 . 

net/network.o: In function `lecd_attach':
net/network.o(.text+0x5ce78): undefined reference to `prepare_trdev'
net/network.o(.text+0x5ce88): undefined reference to `prepare_etherdev'
net/network.o(.text+0x5cee3): undefined reference to `publish_netdev'
make: *** [vmlinux] Error 1

Regards,
-Frank
----__JNP_000_7074.230c.49e0
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dwindows-1252" http-equiv=3DContent-=
Type>
<META content=3D"MSHTML 5.00.2314.1000" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 rightMargin=3D3 topMargin=3D0>
<DIV>Hello,</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; I received the following error while =
compiling=20
test13-pre6 . </DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"></SPAN>&nbsp;</=
DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'">net/network.o: In=
=20
function `lecd_attach':<BR>net/network.o(.text+0x5ce78): undefined =
reference to=20
`prepare_trdev'<BR>net/network.o(.text+0x5ce88): undefined reference to=20
`prepare_etherdev'<BR>net/network.o(.text+0x5cee3): undefined reference to=
=20
`publish_netdev'<BR>make: *** [vmlinux] Error 1</SPAN></DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'"></SPAN>&nbsp;</=
DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'">Regards,</SPAN></=
DIV>
<DIV><SPAN=20
style=3D"mso-fareast-font-family: 'MS Mincho'">-Frank<BR></DIV></SPAN></=
BODY></HTML>

----__JNP_000_7074.230c.49e0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
