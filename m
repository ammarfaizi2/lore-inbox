Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUHVMHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUHVMHH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUHVMHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:07:07 -0400
Received: from the-village.bc.nu ([81.2.110.252]:38030 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266674AbUHVMHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:07:04 -0400
Subject: Re: Fwd: LowFree memory going down -server freezes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Julia M <juliamrus@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040821223551.67748.qmail@web41101.mail.yahoo.com>
References: <20040821223551.67748.qmail@web41101.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093172695.24344.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 12:04:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-21 at 23:35, Julia M wrote:
> I am using Linux version 2.4.9-e.3smp
> (bhcompile@stripples.devel.redhat.com) (gcc version 2
> .96 20000731 (Red Hat Linux 7.2 2.96-108.1)) #1 SMP
> Fri May 3 16:48:54 EDT 2002

The Red Hat 7.x kernel is very very old and probably the best way to get
the box happy is to run something modern on it - bugs get fixed by new
versions and there have been a lot of those for the kernel since 2.4.9.
If its Red Hat Enterprise Linux rather than RH 7.x you should probably
ask on the Red Hat rhel lists because (out of neccessity) the 2.1 VM is
very different to the base kernel and most of the folks who know and
care about it probably live on the Red Hat list.

Alan

