Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWHMRId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWHMRId (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 13:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWHMRId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 13:08:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55820 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751327AbWHMRIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 13:08:32 -0400
Date: Sun, 13 Aug 2006 19:08:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH for review] [123/145] i386: make fault notifier unconditional and export it
Message-ID: <20060813170831.GG3543@stusta.de>
References: <20060810935.775038000@suse.de> <20060810193722.8082B13B8E@wotan.suse.de> <20060813152859.GB3543@stusta.de> <1155489105.24077.154.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155489105.24077.154.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 06:11:45PM +0100, Alan Cox wrote:
> Ar Sul, 2006-08-13 am 17:28 +0200, ysgrifennodd Adrian Bunk:
> > > It's needed for external debuggers and overhead is very small.
> > >...
> > 
> > We are currently trying to remove exports not used by any in-kernel 
> > code.
> 
> Wrong pronoun. I think you meant to type "You".

"You are currently trying to remove exports..."?
Wouldn't this sound as if Andi was doing this?

I thought the "We" was correct since it's at least Arjan and me.

If this was wrong all I can say is that I'm not a native English 
speaker.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

