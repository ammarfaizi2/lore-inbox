Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLQR3F>; Sun, 17 Dec 2000 12:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbQLQR2z>; Sun, 17 Dec 2000 12:28:55 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:27109 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S129413AbQLQR2v>; Sun, 17 Dec 2000 12:28:51 -0500
To: linux-kernel@vger.kernel.org
Date: Sun, 17 Dec 2000 11:50:53 -0500
Subject: test13-pre2, fpu_entry.c compile error
Message-ID: <20001217.115100.-378371.1.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_69ff.260d.4ade
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_69ff.260d.4ade
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

Hello,
  I haven't seen this posted yet, so I have included it below.
Regards,
Frank

fpu_entry.c: In function `math_emulate':
fpu_entry.c:194: structure has no member named `segments'
make[2]: *** [fpu_entry.o] Error 1
make[2]: Leaving directory `/usr/src/linux/arch/i386/math-emu'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/arch/i386/math-emu'
make: *** [_dir_arch/i386/math-emu] Error 2
----__JNP_000_69ff.260d.4ade
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dwindows-1252" http-equiv=3DContent-=
Type>
<META content=3D"MSHTML 5.00.2314.1000" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 rightMargin=3D3 topMargin=3D0>
<DIV>Hello,</DIV>
<DIV>&nbsp; I&nbsp;haven't seen this posted yet, so I have included it=20
below.</DIV>
<DIV>Regards,</DIV>
<DIV>Frank</DIV>
<DIV><FONT face=3D"Courier New" size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>fpu_entry.c: In function=20
`math_emulate':<BR>fpu_entry.c:194: structure has no member named=20
`segments'<BR>make[2]: *** [fpu_entry.o] Error 1<BR>make[2]: Leaving =
directory=20
`/usr/src/linux/arch/i386/math-emu'<BR>make[1]: *** [first_rule] Error=20
2<BR>make[1]: Leaving directory `/usr/src/linux/arch/i386/math-emu'<BR>make=
: ***=20
[_dir_arch/i386/math-emu] Error 2<BR></DIV>
<P></P></FONT></BODY></HTML>

----__JNP_000_69ff.260d.4ade--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
