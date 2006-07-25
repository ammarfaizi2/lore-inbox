Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWGYTUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWGYTUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWGYTUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:20:40 -0400
Received: from vsmtp1.tin.it ([212.216.176.141]:12677 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S964827AbWGYTUj convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:20:39 -0400
From: Francesco Biscani <biscani@pd.astro.it>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Date: Tue, 25 Jul 2006 21:20:12 +0200
User-Agent: KMail/1.9.3
Cc: Andrea Arcangeli <andrea@suse.de>, Nikita Danilov <nikita@clusterfs.com>,
       Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
References: <44C12F0A.1010008@namesys.com> <20060725123558.GA32243@opteron.random> <44C65931.6030207@namesys.com>
In-Reply-To: <44C65931.6030207@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607252120.14329.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 July 2006 19:47, Hans Reiser wrote:
> Wow, I would never have guessed our market share was that high as 1/5th
> of ext3.  I mean, you can't even get a distro which allows you to
> install onto reiser4 without hours of work so far as I know.  I guess
> there are people who really do care about twice as fast.
>
> Hans
>

Yes, this was a pleasant surprise indeed :)

This useless mail from a mere user is just to testify that I've used reiser4 
on my laptop since June 2004, and that, barring occasional hiccups, I never 
had serious problems with it. In fact I haven't lost a single bit of data 
despite crashes and cold shutdowns due to power outage.

I don't know if this means something or if I've just been lucky, but it seems 
to me that when reiser4 crashes (and sometimes it does, given its young age), 
it behaves very very well. That's the thing that impressed me the most (and 
it is really something, given for example the debacle of a mature filesystem 
like XFS in 2.6.17). Oh, and performance, of course ;)

I really hope that the technical difficulties that are preventing reiser4 from 
entering mainline will be sorted out soon.

Thanks,

  Francesco (crawling back in the shadow)

-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
