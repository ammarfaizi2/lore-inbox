Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUG0VkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUG0VkT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 17:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUG0VkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 17:40:19 -0400
Received: from waste.org ([209.173.204.2]:28049 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266650AbUG0VkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 17:40:15 -0400
Date: Tue, 27 Jul 2004 16:40:10 -0500
From: Matt Mackall <mpm@selenic.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Message-ID: <20040727214009.GV5414@waste.org>
References: <200407271233.04205.gene.heskett@verizon.net> <200407271343.43583.gene.heskett@verizon.net> <20040727103256.2691d6f9.rddunlap@osdl.org> <200407271402.59846.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407271402.59846.gene.heskett@verizon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 02:02:59PM -0400, Gene Heskett wrote:
> On Tuesday 27 July 2004 13:32, Randy.Dunlap wrote:
> [...]
> Gene Heskett wrote:
> >| I take it that I should apply these to a 2.6.7 tarballs tree in
> >| this order:
> >| 1. 2.6.8-rc1
> >|
> >>>>> 2.6.8-rc2 <<<<<
> 2.6.8-rc2?  These patches I got will need to be reverted then?

You might find my ketchup script handy for this purpose:

http://selenic.com/ketchup/

You just tell it what version you want and it does all the work.

-- 
Mathematics is the supreme nostalgia of our time.
