Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVCORbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVCORbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVCOR3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:29:30 -0500
Received: from waste.org ([216.27.176.166]:36016 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261604AbVCOR1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:27:42 -0500
Date: Tue, 15 Mar 2005 09:27:24 -0800
From: Matt Mackall <mpm@selenic.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Paul Jackson <pj@engr.sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [PATCH][1/2] SquashFS
Message-ID: <20050315172724.GO32638@waste.org>
References: <4235BAC0.6020001@lougher.demon.co.uk> <20050315003802.GH3163@waste.org> <42363EAB.3050603@yahoo.com.au> <20050315004759.473f6a0b.pj@engr.sgi.com> <42370442.7020401@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42370442.7020401@lougher.demon.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 03:50:26PM +0000, Phillip Lougher wrote:
> Paul Jackson wrote:
> >In the overall kernel (Linus's bk tree) I count:
> >
> >	733 lines matching 'for *( *; *; *)'
> >	718 lines matching 'while *( *1 *)'
> >
> >In the kernel/*.c files, I count 15 of the 'for(;;)' style and 1 of the
> >'while(1)' style.
> >
> >Certainly the 'for(;;)' style is acceptable, and even slightly to
> >substantially dominant, depending on which piece of code you're in.
> >
> 
> I prefer the 'while' style, and only used 'for' because that's what I 
> thought the kernel used.
> 
> If no-one objects I'll change it back to while...
> 
> Shouldn't issues like this be in the coding style document?

This particular point is rather trivial. Do whatever suits you.

-- 
Mathematics is the supreme nostalgia of our time.
