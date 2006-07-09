Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWGIMPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWGIMPX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 08:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWGIMPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 08:15:23 -0400
Received: from 1wt.eu ([62.212.114.60]:10 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1030465AbWGIMPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 08:15:22 -0400
Date: Sun, 9 Jul 2006 14:15:11 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Abu M. Muttalib" <abum@aftek.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>,
       chase.venters@clientec.com, kernelnewbies@nl.linux.org,
       linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Commenting out out_of_memory() function in __alloc_pages()
Message-ID: <20060709121511.GD2037@1wt.eu>
References: <20060709120138.GC2037@1wt.eu> <BKEKJNIHLJDCFGDBOHGMCEFFDCAA.abum@aftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMCEFFDCAA.abum@aftek.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 05:43:11PM +0530, Abu M. Muttalib wrote:
> Thanks Willy for your reply..
> 
> In this context will you please help me understand/give some pointer to
> understand the various field in the output of /proc/meminfo!!

It's explained in Documentation/filesystems/proc.txt. This file know far
more things than me :-)

> Anticipation and regards,
> Abu.

Regards,
willy

