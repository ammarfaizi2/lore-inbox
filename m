Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTKNQpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTKNQpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:45:24 -0500
Received: from stud4.tuwien.ac.at ([193.170.75.21]:49402 "EHLO
	stud4.tuwien.ac.at") by vger.kernel.org with ESMTP id S262792AbTKNQpT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:45:19 -0500
From: Roland Lezuo <roland.lezuo@chello.at>
To: Martin Diehl <lists@mdiehl.de>, Davide Libenzi <davidel@xmailserver.org>
Subject: Re: 2.4.23-rc1: SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
Date: Fri, 14 Nov 2003 17:44:50 +0100
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311140928350.19678-100000@notebook.home.mdiehl.de>
In-Reply-To: <Pine.LNX.4.44.0311140928350.19678-100000@notebook.home.mdiehl.de>
X-MSMail-Priority: High
Reply-By: Sat, 18 Oct 2004 08:00:00 +0100
X-message-flag: Outlook says: It is not clever to use me! I'm full of bugs and everyone can hack me!
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311141745.11770.roland.lezuo@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Roland, could you send the output from "lspci -vxxx -d:8" please for
> verification?
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
        Flags: bus master, medium devsel, latency 0
00: 39 10 08 00 0f 00 00 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 9a 0b 0c 05 0b 22 31 09 10 00 00 00 11 20 04 01
50: 11 28 02 01 62 00 63 00 9c 2e 12 00 36 06 00 00
60: 80 80 80 09 40 c1 0c 10 80 80 00 02 d0 00 00 00
70: 00 00 00 00 00 50 00 fc 00 00 00 00 06 00 01 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I am willed to test any patch or even write one (with some help and tips ;)

regards
Roland Lezuo
- -- 
PGP Key ID: 0xFCC9ED1E
http://members.chello.at/roland.lezuo/ <- l337 zup4 h4x0r 4nd c0d3r h0meb4se
root@server:/ >mount -t inetfs /dev/inet /mnt/tmp
root@server:/ >rm -rf /mnt/tmp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tQaL5qlVDPzJ7R4RAuQTAKCkto4xU13oh6Pv3P7KQ2P6FY+c5gCeP2pz
woHl+AjfSLaDzY4KfVzOyPs=
=Fiao
-----END PGP SIGNATURE-----

