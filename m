Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVD3TAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVD3TAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 15:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVD3TAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 15:00:09 -0400
Received: from web60216.mail.yahoo.com ([209.73.178.104]:59312 "HELO
	web60216.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261342AbVD3S7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:59:52 -0400
Message-ID: <20050430185946.80225.qmail@web60216.mail.yahoo.com>
Date: Sat, 30 Apr 2005 14:59:45 -0400 (EDT)
From: john doe <catcowcrow@yahoo.ca>
Subject: Re: ATA port addresses
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the advice, its probably as you say to go
through the kernel and drivers.

Thanks again!


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2005-04-29 at 16:37, john doe wrote:
> > Thank you for the prompt reply!
> > 
> > I'll look at this option closer.  Is there a way
> to
> > bypass the IDE driver though? 
> 
> Write your own kernel 8) There isn't really a way to
> bypass it and since
> you rely on the kernel for functionality like mmap
> you rely on it for
> trust anyway. More pressingly you need DMA
> functionality for some
> hardware and the newer devices are all getting very
> clever and sometimes
> very unique in their interfacing
> 
> 

______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
