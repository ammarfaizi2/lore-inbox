Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUCZVzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUCZVzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:55:07 -0500
Received: from dhcp18-183.bio.purdue.edu ([128.210.18.183]:11648 "EHLO
	lapdog.ravenhome.net") by vger.kernel.org with ESMTP
	id S261347AbUCZVzB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:55:01 -0500
From: Praedor Atrebates <praedor@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: System clock speed too high - 2.6.3 kernel
Date: Fri, 26 Mar 2004 16:54:50 -0500
User-Agent: KMail/1.6.1
References: <200403261430.18629.praedor@yahoo.com> <1080336165.5408.307.camel@cog.beaverton.ibm.com>
In-Reply-To: <1080336165.5408.307.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403261654.57525.praedor@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 March 2004 04:22 pm, john stultz held forth thus:
> On Fri, 2004-03-26 at 11:30, Praedor Atrebates wrote:
> > In doing a web search on system clock speeds being too high, I found
> > entries describing exactly what I am experiencing in the linux-kernel
> > list archives, but have not yet found a resolution.
[...]
> > Does anyone have any enlightenment, or a fix, to offer?  The exact same
> > software setup on a desktop system, Athlon XP2700+, has no such problems.
>
> Could you please send me dmesg output for this system?
>
> Does booting w/ "clock=pit" help?

Thank you, this did fix the problem.  Now I have to set the type-matic setting 
up because it is so sluggish.  

What is clock=pit doing?  What is behind this accelerated clock?

praedor
-- 
"George W. Bush is a deserter, an election thief, a drunk driver, a WMD 
liar and a functional illiterate. And he poops his pants." 
--Barbara Bush, his mother
