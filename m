Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVAQStl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVAQStl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVAQStl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:49:41 -0500
Received: from mail.dif.dk ([193.138.115.101]:5521 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262558AbVAQSqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:46:53 -0500
Date: Mon, 17 Jan 2005 19:49:42 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Brian Henning <brian@strutmasters.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smbfs in 2.6.8 SMP kernel
In-Reply-To: <41EC003B.7040606@strutmasters.com>
Message-ID: <Pine.LNX.4.61.0501171939190.2730@dragon.hygekrogen.localhost>
References: <41EBD4E8.70905@strutmasters.com> <Pine.LNX.4.61.0501171633140.20155@jjulnx.backbone.dif.dk>
 <41EC003B.7040606@strutmasters.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, Brian Henning wrote:

> Jesper Juhl wrote:
> > If I remember correctly there was some smbfs breakage a few releases back -
> > 2.6.8 sounds about right. I'd suggest you try a newer kernel like 2.6.10 or
> > 2.6.11-rc1 and see if that works better.
> 
> No luck with smbfs in 2.6.10 with SMP either; however, I discovered the
> existence of CIFS (which I previously did not know about), and it appears to
> work smoothly in place of smbfs.
> 
Perhaps if you could provide some more details on the breakage, that would 
make it easier for people to help you and track down the bug. Take a look 
at the REPORTING-BUGS document in the kernel source dir for a sample 
bugreporting form that will help you get all relevant details posted (in 
addition to what you already posted).


-- 
Jesper Juhl

