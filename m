Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285724AbRLYSql>; Tue, 25 Dec 2001 13:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285730AbRLYSqh>; Tue, 25 Dec 2001 13:46:37 -0500
Received: from [129.27.43.9] ([129.27.43.9]:64518 "EHLO xarch.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S285724AbRLYSqU>;
	Tue, 25 Dec 2001 13:46:20 -0500
Date: Tue, 25 Dec 2001 19:46:18 +0100 (CET)
From: Alex <mail_ker@xarch.tu-graz.ac.at>
To: linux-kernel@vger.kernel.org
Subject: apology: arp.c is not buggy :-)
Message-ID: <Pine.LNX.4.10.10112251943260.24118-100000@xarch.tu-graz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Mailinglist,

I'm terribly sorry - the arp.c code is *not* buggy, as I was surmising. I
suffered from a faulty configuration file causing to assign a wrong
interrupt to eth0. Thanx to Alan Cox for the fast - and correct - clues
going in the right direction. I'll volunteer to add my stupidity to some
network-faq-file. :-)

Alex


