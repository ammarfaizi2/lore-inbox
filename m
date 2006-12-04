Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937016AbWLDP3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937016AbWLDP3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 10:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937017AbWLDP3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 10:29:00 -0500
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:37018 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S937016AbWLDP27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 10:28:59 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.6
Subject: 100000 interrupts problem Re: linux 2.6.19 still crashing
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4573CFBB.1030107@dungeon.inka.de>
References: <4571AFED.8060200@dungeon.inka.de>
	 <1165200588.9189.1.camel@monteirov>  <4573CFBB.1030107@dungeon.inka.de>
Content-Type: text/plain; charset=utf-8
Date: Mon, 04 Dec 2006 15:28:59 +0000
Message-Id: <1165246139.4546.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 08:35 +0100, Andreas Jellinghaus wrote:
> or I can send you the kernel patch as file and the xen hypervisor:
> -rw-r--r-- 1 root root  244694 2006-04-19 12:14 /boot/xen-3.0.2-2.gz
> -rw-r--r-- 1 root root  604942 2006-04-19 12:14 
> /usr/src/kernel-patches/diffs/xen/linux-2.6.16-xen.patch.gz
> 
> it applies clean against 2.6.16, but if with 2.6.16.31 I had
> to manually fix two rejects. 

Send me this (patches) please I like to try it, I work with rpms , so
don't send me debs.

yesterday, I had try 2.6.19-rt1
( http://people.redhat.com/mingo/realtime-preempt/ )
which don't show the 100000 interrupts problem anymore, but was just a
preliminary test.

Thanks,
--
Sérgio M. B. 
  

