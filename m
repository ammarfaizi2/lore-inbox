Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTKMLuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTKMLuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:50:44 -0500
Received: from stud4.tuwien.ac.at ([193.170.75.21]:13302 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S264123AbTKMLum convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:50:42 -0500
From: Roland Lezuo <roland.lezuo@chello.at>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23-rc1: SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
Date: Thu, 13 Nov 2003 12:50:26 +0100
User-Agent: KMail/1.5.4
X-MSMail-Priority: High
Reply-By: Sat, 18 Oct 2004 08:00:00 +0100
X-message-flag: Outlook says: It is not clever to use me! I'm full of bugs and everyone can hack me!
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311131250.42465.roland.lezuo@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on my Sis 745 Chipset neither psaux nor USB is working as it should. I can 
only use serial mice on this box.

<from dmesg>
SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
SiS router unknown request: (97)
SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
SiS router unknown request: (97)

I though the patch has already been merged?
If you need any more info about the system please CC me.

regards 
Roland Lezuo
- -- 
PGP Key ID: 0xFCC9ED1E
http://members.chello.at/roland.lezuo/ <- l337 zup4 h4x0r 4nd c0d3r h0meb4se
root@server:/ >mount -t inetfs /dev/inet /mnt/tmp
root@server:/ >rm -rf /mnt/tmp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/s3AM5qlVDPzJ7R4RAnRKAJ9SvTLYh+BiZtyn1BCPImqrjK8BfwCgtITv
HHhcTIa+iTWbo3jG8ujZnxQ=
=TIH+
-----END PGP SIGNATURE-----

