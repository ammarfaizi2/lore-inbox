Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276429AbRJHNR0>; Mon, 8 Oct 2001 09:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276829AbRJHNRQ>; Mon, 8 Oct 2001 09:17:16 -0400
Received: from m2.bezeqint.net ([192.115.106.47]:5979 "EHLO m2.bezeqint.net")
	by vger.kernel.org with ESMTP id <S276429AbRJHNRC>;
	Mon, 8 Oct 2001 09:17:02 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: PCI driver works, why not supporting the EISA bus too?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 15:16:46 +0200
From: Shaul Karl <shaulka@bezeqint.net>
Message-Id: <E15qaH9-0003RS-00@rakefet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting http://www.geocities.com/rlcomp_1999/pl4500.html, 
(Updated June 11, 2001; Created May 10, 2001)

...

Q5. What is the chipset of the embedded (integrated) SCSI on the
    PL4500 and is there a Linux driver for it? 
A5. The chipset for the embedded SCSI controller on the PL4500 is the
    NCR53C825. The NCR53C8XX chipset in the PL4500 IS ON THE
    EISA BUS. Two drivers exist for the PCI version of this chipset:
    NCR53C8xx and SYM53c8xx; however, these drivers ONLY work with
    the PCI bus and WILL NOT WORK with the EISA bus. So the answer
    is: No, there is no Linux driver for the embedded SCSI controller
    on the PL4500. 


The reference is

<BASE HREF="http://www.geocities.com/rlcomp_1999/">
<HTML>
<HEAD>
<TITLE>Linux and Compaq PL4500</TITLE>

<LINK REV="made" HREF="mailto:richard.black@compaq.com">
<META NAME="author" content="Richard Black">
<META name="keywords" content="linux, Linux, compaq, Compaq, PL4500, ProLiant 
4500">
<META name="description" content="Installing Linux on a Compaq ProLiant 
(PL4500) server.">


-- 

	Shaul Karl <shaulka@bezeqint.net>


