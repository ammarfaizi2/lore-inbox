Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUCWSFR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 13:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbUCWSFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 13:05:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44260 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262750AbUCWSFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 13:05:09 -0500
Message-ID: <40607C46.8000409@pobox.com>
Date: Tue, 23 Mar 2004 13:04:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       miquels@cistron.nl
Subject: [sata]  libata update
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds a driver for SiS SATA, and updates Intel ICH5 (ata_piix) 
probing.  Particularly users with combined mode probing problems and 
modprobe+rmmod+modprobe problems.  Please test.

BK repositories (note that these URLs are BK not HTTP):
	http://gkernel.bkbits.net/libata-2.4
	http://gkernel.bkbits.net/libata-2.6

Patches:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.25-libata11.patch.bz2
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.5-rc2-bk3-libata1.patch.bz2

This will go upstream once 2.6.5 is released.



