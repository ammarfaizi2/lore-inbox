Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVA1JOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVA1JOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 04:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVA1JOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 04:14:19 -0500
Received: from web60601.mail.yahoo.com ([216.109.118.221]:9900 "HELO
	web60601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261224AbVA1JOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 04:14:15 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=5fXnr8Nh9ER48vZ3UO0E0HHi3jXJskQOdyThlm2CMrC0vc0h4Ht7XPg/smBiuA9jI3VrlunqEcbfQgjLLSgId3yZGLP5tZYWZRR2T92yZlgn8umVfKcyoXmd/icRhGER2OFjH3nAZxoiTNaEPJ3SN+HW/4i60pM5NUvcFzv7Ck4=  ;
Message-ID: <20050128091414.49184.qmail@web60601.mail.yahoo.com>
Date: Fri, 28 Jan 2005 01:14:14 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Error : kernel error when obj-m is replaced with obj-y
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I included my module into the main kernel object
file by modifying the top Makefile i.e obj-y magic.
Now, when I reboot the system the module works. But in
the new hardware detection phase, X server and other
applications failed. The kernel prompted to repair the
file system and to reboot the system. The file system
was opened as a readonly file system. How can I get
rid of this? My module intercepts some syscalls in
kernel 2.4.28.

Thanks in advance and regards,
selva


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Helps protect you from nasty viruses. 
http://promotions.yahoo.com/new_mail
