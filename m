Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267484AbUGNRrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267484AbUGNRrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUGNRrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:47:20 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9641 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267484AbUGNRrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:47:18 -0400
Subject: Re: [linux-audio-user] Re: linux-audio-user Digest, Vol 10, Issue
	55
From: Lee Revell <rlrevell@joe-job.com>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>
In-Reply-To: <40F5582A.3020509@controlnet.com>
References: <200407131600.i6DG0AwS002424@roar.music.columbia.edu>
	 <Pine.GSO.4.21.0407131043310.7200-100000@muse.calarts.edu>
	 <20040714120119.21ea1587@sund32>  <40F5582A.3020509@controlnet.com>
Content-Type: text/plain
Message-Id: <1089827237.2104.53.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 13:47:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-14 at 11:58, Mark Knecht wrote:
> Markus Schwarzenberg wrote:
> > On Tue, 13 Jul 2004 10:44:44 -0700 (PDT) Brian Redfern
> > <bredfern@calarts.edu> wrote:
> > 
> > 
> >>2.6 on suse is also different than 2.6 fedora, because suse has a
> >>couple of audio programmers who work to make sure their kernel works
> >>with audio, so I can use all my audio apps out of the box with 9.2,
> >>and the 2.6 kernel, without latency problems, and without needing a
> >>kernel recompile.
> > 
> > 
> > Suse 9.2 ? I thought they are at 9.1, currently - no hints to 9.2 on
> > their web site (It's funny, there are some more "suse 9.2" google matches).
> > 
> > So, apparently suse 9.1 does have an audio friendly kernel?
> > 
> 
> I believe that Takashi-san works for Suse. He recently posted a paper 
> showing some latency numbers for different distributions. Suse did quite 
> well as I remember. It was my impression that this was not an accident 
> and that he had played a part in making sure this was true.
> 
> It made me briefly consider trying Suse out... ;-0
> 

Speaking of which, can someone from SuSe somment on whether they use a
modified ReiserFS?  The tests I have been running (see my recent posts
to linux-kernel) showed some latency problems with reiserfs that I did
not see with ext3.  There was a latency-related thread on LKML in March
where Takashi mentioned a few changes to reiserfs that would give
excellent latency.

It seems very likely that with these changes, reiserfs is just as good
as ext3.  I have not heard much from the reiserfs advocates on this
issue.

Lee

