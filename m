Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWBQRBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWBQRBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 12:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBQRBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 12:01:40 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:14599 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750708AbWBQRBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 12:01:39 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C633E3.D02F6E80"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 17 Feb 2006 17:01:37.0916 (UTC) FILETIME=[D0BB33C0:01C633E3]
Content-class: urn:content-classes:message
Subject: C/H/S from user space
Date: Fri, 17 Feb 2006 12:01:37 -0500
Message-ID: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: C/H/S from user space
thread-index: AcYz49DEou1ety6OQZ2MxK9JT0ZQZg==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C633E3.D02F6E80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



For those who think that C/H/S translation is useful,
attached is a simple program that gets whatever the BIOS
used from user-space. If you have large media (most do),
you will descover that C/H/S is useless because it is
always set to "MAX" like this:

 	Disk parameter table(s) at vector 0x41
Disk0
     Cylinders =3D 1024
       Sectors =3D 63
         Heads =3D 255
Write precomp =3D 0
  Landing zone =3D 65296
 	Reserved bit 0 set
 	Reserved bit 1 set
 	Reserved bit 2 set
 	More than 8 heads
 	Reserved bit 4 set
 	Defect map present
 	Disable retries
 	Disable retries
Disk1
     Cylinders =3D 306
       Sectors =3D 1
         Heads =3D 4
Write precomp =3D 0
  Landing zone =3D 12544
 	Disk parameter table(s) at vector 0x46
Disk0
     Cylinders =3D 306
       Sectors =3D 1
         Heads =3D 4
Write precomp =3D 0
  Landing zone =3D 12544
Disk1
     Cylinders =3D 306
       Sectors =3D 1
         Heads =3D 4
Write precomp =3D 0
  Landing zone =3D 12544


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
_
=1A=04


****************************************************************
The information transmitted in this message is confidential and may be=
 privileged.  Any review, retransmission, dissemination, or other use of=
 this information by persons or entities other than the intended recipient=
 is prohibited.  If you are not the intended recipient, please notify=
 Analogic Corporation immediately - by replying to this message or by=
 sending an email to DeliveryErrors@analogic.com - and destroy all copies=
 of this information, including any attachments, without reading or=
 disclosing them.

Thank you.
------_=_NextPart_001_01C633E3.D02F6E80
Content-Type: APPLICATION/x-gzip;
	name="CHS.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: CHS.tar.gz
Content-Disposition: attachment;
	filename="CHS.tar.gz"

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

------_=_NextPart_001_01C633E3.D02F6E80--
