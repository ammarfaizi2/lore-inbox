Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbUKEEGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbUKEEGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUKEEGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:06:44 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:24298 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262591AbUKEEFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:05:53 -0500
From: "Scott Lockwood" <lkml@lrsehosting.com>
To: "=?iso-8859-1?Q?'J=E9r=F4me_Petazzoni'?=" <jp@enix.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Possible GPL infringement in Broadcom-based routers
Date: Thu, 4 Nov 2004 22:05:47 -0600
Message-ID: <00b001c4c2ec$baf0a520$0500a8c0@54GDL8PX41>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00B1_01C4C2BA.70563520"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <418ABC5F.6060200@enix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00B1_01C4C2BA.70563520
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I work for lawyers. Let me know if you would like a referral.

Regards,=20
Scott Lockwood=20

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of J=E9r=F4me
Petazzoni
Sent: Thursday, November 04, 2004 5:34 PM
To: linux-kernel@vger.kernel.org
Subject: Possible GPL infringement in Broadcom-based routers


The following routers (and they might be other models, too) :
- Us Robotics 9105 (without wireless) and 9106 (with wireless)
- Siemens SE515
- Dynalink RTA230
- Buffalo WMR-G54
- Inventel DBW-200

... are all based on the same Broadcom chipset (96345 board). They=20
integrate a 4-ports Ethernet switch, a 802.11g wireless access point,=20
and a DSL modem (and doing routing and/or bridging between those=20
interfaces). The CPU runs the MIPS32 instruction set. It runs a 2.4.17=20
linux-mips kernel with additional patches, and is loaded with a lot of=20
free software (busybox, uclibc, zebra...)

The vendors (probably Broadcom, in fact) had to patch the kernel to=20
support the DSL modem, the wireless interface (which is a PCMCIA-hosted=20
BCM4306 ; which already was subject of heated debates earlier), and also

some generic stuff like the flash memory and the front leds.=20
Miscellaneous vendors provide so-called "GPL sources", which are=20
generally mutilated kernels, lacking all the "interesting" parts=20
(wireless and DSL drivers for instance).

Can Broadcom and the vendors "escape" the obligations of the GPL by=20
shipping those proprietary drivers as modules, or are they violating the

GPL plain and simple by removing the related source code (and showing=20
irrelevant code to show "proof of good will") ?

Broadcom has been contacted about this matter but hasn't answered so=20
far, nor did US Robotics (I tried to contact USR since I own a USR
router).

Any suggestions about the legal (or if it's a lost cause, technical!)=20
ways to get support for this platform will be very welcome.

More information can be found here :
http://skaya.enix.org/wiki/GplInfringement (some extra details)
http://skaya.enix.org/wiki/BroadCom96345 (technical info that I gathered

about the router, firmware and kernel formats, etc.)
http://sourceforge.net/projects/brcm6345-linux/ (sourceforge project)

Best regards,
J=E9r=F4me Petazzoni <jp at enix dot org>
PS: please be kind and cc me, as my lkml awareness is limited to KT ...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------=_NextPart_000_00B1_01C4C2BA.70563520
Content-Type: text/x-vcard;
	name="Scott Lockwood.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Scott Lockwood.vcf"

BEGIN:VCARD
VERSION:2.1
N:Lockwood;Scott
FN:Scott Lockwood
TITLE:User Support Specialist
TEL;WORK;VOICE:+1 (312) 602-5140
TEL;HOME;VOICE:+1 (815) 723-2101
TEL;CELL;VOICE:+1 (312) 617-8626
TEL;VOICE:815-557-7443
TEL;WORK;FAX:+1 (312) 602-5050
EMAIL;PREF;INTERNET:Scott.Lockwood@bryancave.com
REV:20041011T173726Z
END:VCARD

------=_NextPart_000_00B1_01C4C2BA.70563520--

