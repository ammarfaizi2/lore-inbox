Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVJGKLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVJGKLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 06:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJGKLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 06:11:48 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:61357 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S932367AbVJGKLr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 06:11:47 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-raid@vger.kernel.org
Subject: Anybody know about nforce4 SATA II hot swapping + linux raid?
Date: Fri, 7 Oct 2005 11:11:46 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510071111.46788.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need to deploy some very resilient servers with hot swapable drives.

I always used dac960 based hardware raid for hot swapping in the past, but 
sata drives are so cheap compared to scsi that I'm considering the Tyan GT24 
server with 4 hot swappable SATA II drives (nforce4 pro controller)

	http://www.tyan.com/products/html/gt24b2891.html

Before I place an order, I need to know whether sata II hot swapping is up to 
scratch in the linux kernel, and whether it works nicely with linux software 
raid (which I already use/am familiar with).

Any knowledge greatfully accepted :)

Andrew Walrond
