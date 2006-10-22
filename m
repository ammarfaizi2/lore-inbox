Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWJVT5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWJVT5u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWJVT5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:57:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16622 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751227AbWJVT5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:57:50 -0400
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Avi Kivity <avi@qumranet.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
In-Reply-To: <200610221851.06530.arnd@arndb.de>
References: <4537818D.4060204@qumranet.com>
	 <200610221723.48646.arnd@arndb.de> <453B99D7.1050004@qumranet.com>
	 <200610221851.06530.arnd@arndb.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Oct 2006 20:59:28 +0100
Message-Id: <1161547168.1919.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-22 am 18:51 +0200, ysgrifennodd Arnd Bergmann:
> What is the point of 32 bit hosts anyway? Isn't this only available
> on x86_64 type CPUs in the first place?

There are a small number of vt capable 32bit only processors.

