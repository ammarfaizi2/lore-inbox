Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUKSMd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUKSMd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUKSMb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:31:28 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:49900 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261393AbUKSM27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:28:59 -0500
Subject: Re: Linux 2.6.9-ac10
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: CaT <cat@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041119030741.GC1231@zip.com.au>
References: <1100789415.6005.1.camel@localhost.localdomain>
	 <20041119030741.GC1231@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100863548.8127.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 19 Nov 2004 11:25:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-11-19 at 03:07, CaT wrote:
> On Thu, Nov 18, 2004 at 02:50:16PM +0000, Alan Cox wrote:
> > The it8212 still doesn't default to DMA on - that is on the TODO list. The
> 
> Are you sure?

It will in pass through or with no RAID volume present but not with a
hardware raid volume

