Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311701AbSCXSEu>; Sun, 24 Mar 2002 13:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311661AbSCXSEc>; Sun, 24 Mar 2002 13:04:32 -0500
Received: from [64.66.228.215] ([64.66.228.215]:48651 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S311642AbSCXSEO>; Sun, 24 Mar 2002 13:04:14 -0500
Date: Sun, 24 Mar 2002 12:03:37 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Screen corruption in 2.4.18
Message-ID: <20020324180337.GA925@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020324155930.GA20926@hapablap.dyn.dhs.org> <E16pBAL-0006f2-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 12:01:59 up 3 days, 10:59,  0 users,  load average: 1.38, 1.13, 1.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 04:48:20PM +0000, Alan Cox wrote:
> > Here is a patch which should apply cleanly to everyone's tree, which
> > only clears bit 7 on all chips except the KT266.  No problems have been
> > reported there, so I'm leaving well enough alone.  Please apply.
> 
> No. Not until someone explains to me why VIA specifically told me I must
> clear the 3 bits. If you get that wrong you get slow and insidious disk
> corruption. Its hard to test and I'm not going to use other people's
> hardware as target practice for a hunch.

I've contacted someone at VIA about it, but have yet to hear back.
You'll be the first to know when I do.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
