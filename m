Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129875AbQKPKiE>; Thu, 16 Nov 2000 05:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbQKPKhz>; Thu, 16 Nov 2000 05:37:55 -0500
Received: from tarzan.bancorp.ru ([195.239.131.101]:36107 "EHLO
	tarzan.bancorp.ru") by vger.kernel.org with ESMTP
	id <S129875AbQKPKhq>; Thu, 16 Nov 2000 05:37:46 -0500
Message-ID: <000801c04fb4$1fe85000$6e07a8c0@ru>
Reply-To: "Sergey Volkoff" <sve@raiden.bancorp.ru>
From: "Sergey Volkoff" <sve@raiden.bancorp.ru>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.0-test11-pre5 System hangup on attempt to mount filesystem ?
Date: Thu, 16 Nov 2000 13:00:58 +0300
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C04FCD.43D50DA0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C04FCD.43D50DA0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

I installed the latest kernel ( 2.4.0-test11-pre5 ). On boot with new =
kernel, system hangup before booting is completed.
I don't know where, but I think this occurs when system is attempt to =
mount filesystems.

Now I use kernel 2.4.0-test-10 and it work fine.

Regards.

Sergey.

------=_NextPart_000_0005_01C04FCD.43D50DA0
Content-Type: text/html;
	charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Dkoi8-r" http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2614.3500" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I installed the latest kernel ( =
2.4.0-test11-pre5=20
). On boot with new kernel, system hangup before booting is=20
completed.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I don't know where, but I think this =
occurs when=20
system is attempt to mount filesystems.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Now I use kernel 2.4.0-test-10 and it =
work=20
fine.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Sergey.</FONT></DIV></BODY></HTML>

------=_NextPart_000_0005_01C04FCD.43D50DA0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
