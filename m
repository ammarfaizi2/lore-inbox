Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUHDLts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUHDLts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUHDLts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:49:48 -0400
Received: from lakermmtao07.cox.net ([68.230.240.32]:21750 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S264373AbUHDLtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:49:46 -0400
Date: Wed, 4 Aug 2004 02:57:52 -0400
From: Chris Shoemaker <c.shoemaker@cox.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The prune_dcache saga, truely epic proportions now
Message-ID: <20040804065752.GA3803@cox.net>
References: <200408031421.58487.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408031421.58487.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 02:21:58PM -0400, Gene Heskett wrote:
> Greetings;
> 
> This machine has repeatadly passed memtest86-3a for as many as a dozen 
> full passes without errors.
> 
> Running 2.6.8-rc2-mm2 which is an improvement, I almost got a 24 hour 
> uptime.  BUT, it just went away again while trying to run the FC2 
> version of up2date.
> 
> Aug  3 13:12:37 coyote kernel: PREEMPT 

Gene,
	I haven't followed the whole thread, but have you tried turning
PREEMPT off?

-chris

