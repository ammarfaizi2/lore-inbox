Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbVHZQVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbVHZQVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVHZQVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:21:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9231 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965099AbVHZQVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:21:39 -0400
Date: Fri, 26 Aug 2005 18:21:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Danial Thom <danial_thom@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 Performance problems
Message-ID: <20050826162132.GH6471@stusta.de>
References: <20050826131750.GG6471@stusta.de> <20050826153414.9643.qmail@web33308.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826153414.9643.qmail@web33308.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 08:34:14AM -0700, Danial Thom wrote:
> 
> --- Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > That's not always true.
> > 
> > Imagine a slow computer with a GBit ethernet
> > connection, where the user 
> > is downloading files from a server that can
> > utilize the full 
> > network connection while listening to music
> > from his local disk with 
> > XMMS.
> > 
> > In this case, the audio stream is not depending
> > on the network 
> > connection. And the user might prefer dropped
> > packages over a stuttering 
> > XMMS.

> Audio connections are going to be windowed/flowed
> in some way (thats how the internet works) so
>...

I was talking about an audio stream coming from a file on the
"local disk", IOW something like an mp3 file.

But the most interesting thing about your email is not what you were 
answering to, but which part of my email you silently omitted. Since you 
are not answering questions that might help to debug the problem you 
claim to have, it seems your intention is not getting a Linux problem 
fixed...

> DT

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

