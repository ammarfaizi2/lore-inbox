Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132795AbRADE6d>; Wed, 3 Jan 2001 23:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132796AbRADE6X>; Wed, 3 Jan 2001 23:58:23 -0500
Received: from m11.boston.juno.com ([63.211.172.74]:12689 "EHLO
	m11.boston.juno.com") by vger.kernel.org with ESMTP
	id <S132795AbRADE6M>; Wed, 3 Jan 2001 23:58:12 -0500
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Date: Wed, 3 Jan 2001 23:51:31 -0500
Subject: 2.4.0-prerelease-ac5 : 'make dep' error
Message-ID: <20010103.235132.-322857.2.fdavis112@juno.com>
X-Mailer: Juno 5.0.15
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary=--__JNP_000_1aae.6e54.24b2
X-Juno-Line-Breaks: 9-6,7,9-14,16-23,24-32767
From: Frank Davis <fdavis112@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.  Since your mail reader does not understand
this format, some or all of this message may not be legible.

----__JNP_000_1aae.6e54.24b2
Content-Type: text/plain; charset=us-ascii  
Content-Transfer-Encoding: 7bit

Hello,
       I received the following make dep error while compiling
prerelease-ac5 .
Regards,
Frank

make -C acpi fastdep
make[4]: Entering directory `/usr/src/linux/drivers/acpi'
/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' references
itself (eventually).  Stop.
make[4]: Leaving directory `/usr/src/linux/drivers/acpi'
make[3]: *** [_sfdep_acpi] Error 2
make[3]: Leaving directory `/usr/src/linux/drivers'
make[2]: *** [fastdep] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers'
make[1]: *** [_sfdep_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [dep-files] Error 2
----__JNP_000_1aae.6e54.24b2
Content-Type: text/html; charset=us-ascii  
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dwindows-1252" http-equiv=3DContent-=
Type>
<META content=3D"MSHTML 5.00.2314.1000" name=3DGENERATOR></HEAD>
<BODY bottomMargin=3D0 leftMargin=3D3 rightMargin=3D3 topMargin=3D0>
<DIV>Hello,</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I received the following make dep=
=20
error while compiling prerelease-ac5 .</DIV>
<DIV>Regards,</DIV>
<DIV>Frank</DIV>
<DIV>&nbsp;</DIV>
<DIV><SPAN style=3D"mso-fareast-font-family: 'MS Mincho'">make -C acpi=20
fastdep<BR>make[4]: Entering directory=20
`/usr/src/linux/drivers/acpi'<BR>/usr/src/linux/Rules.make:224: *** =
Recursive=20
variable `CFLAGS' references itself (eventually).<SPAN=20
style=3D"mso-spacerun: yes">&nbsp; </SPAN>Stop.<BR>make[4]: Leaving =
directory=20
`/usr/src/linux/drivers/acpi'<BR>make[3]: *** [_sfdep_acpi] Error 2<BR>make=
[3]:=20
Leaving directory `/usr/src/linux/drivers'<BR>make[2]: *** [fastdep] Error=
=20
2<BR>make[2]: Leaving directory `/usr/src/linux/drivers'<BR>make[1]: ***=20
[_sfdep_drivers] Error 2<BR>make[1]: Leaving directory `/usr/src/linux'<BR>=
make:=20
*** [dep-files] Error 2<BR></SPAN></DIV></BODY></HTML>

----__JNP_000_1aae.6e54.24b2--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
