Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWJVT7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWJVT7y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 15:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWJVT7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 15:59:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2176 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751179AbWJVT7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 15:59:53 -0400
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Avi Kivity <avi@qumranet.com>, Arnd Bergmann <arnd@arndb.de>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
In-Reply-To: <20061022175609.GA28152@infradead.org>
References: <4537818D.4060204@qumranet.com>
	 <200610221723.48646.arnd@arndb.de> <453B99D7.1050004@qumranet.com>
	 <200610221851.06530.arnd@arndb.de> <453BA3E9.4050907@qumranet.com>
	 <20061022175609.GA28152@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Oct 2006 21:01:23 +0100
Message-Id: <1161547284.1919.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-22 am 18:56 +0100, ysgrifennodd Christoph Hellwig:
> Again, what's the point?  All cpus shipped by Intel and AMD that have
> hardware virtualization extensions also support the 64bit mode.  Given
> that I don't see any point for supporting a 32bit host.

Really:

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx
constant_tsc pni monitor vmx est tm2 xtpr
model name      : Genuine Intel(R) CPU           T2300  @ 1.66GHz

