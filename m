Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbWBIIrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbWBIIrl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 03:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWBIIrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 03:47:41 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750798AbWBIIrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 03:47:40 -0500
Date: Thu, 9 Feb 2006 00:47:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: efault@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: [k2.6.16-rc1-mm5] kernel BUG at include/linux/mm.h:302!
Message-Id: <20060209004712.3998e336.akpm@osdl.org>
In-Reply-To: <43EAFF6D.1040604@yahoo.com.au>
References: <1139473463.8028.13.camel@homer>
	<43EAFF6D.1040604@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> MIke Galbraith wrote:
> > Greetings,
> > 
> > Excuse me if this is already known, I've been too busy tinkering to read
> > lkml.
> > 
> 
> It should be fixed as of current -git (not sure about the latest
> -mm though). It would be good if you could verify that 2.6.16-rc2-git7
> works OK for you.
> 

This was a -mm kernel - how do we know it's not -mm breakage?

IOW: to what bug are you referring?
