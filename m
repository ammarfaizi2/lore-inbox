Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281862AbRKWC2A>; Thu, 22 Nov 2001 21:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281863AbRKWC1u>; Thu, 22 Nov 2001 21:27:50 -0500
Received: from mx1.sac.fedex.com ([199.81.208.10]:52996 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S281862AbRKWC1g>; Thu, 22 Nov 2001 21:27:36 -0500
Date: Fri, 23 Nov 2001 10:27:23 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Shaya Potter <spotter@cs.columbia.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Thinkpad t21 hard lockup when left overnight
In-Reply-To: <1006468789.5778.7.camel@zaphod>
Message-ID: <Pine.LNX.4.42.0111231023490.15987-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 10:27:32 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 10:27:34 AM,
	Serialize complete at 11/23/2001 10:27:34 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Nov 2001, Shaya Potter wrote:

> When I've left my thinkpad on overnight (without apm --suspend'ing it)
> when I wake up in the morning, it's locked up hard.  For some reason it
> seems to run for a few hours w/o any interaction on the machine itself,

You need to run apmd. Without it, it'll freeze your system. I had a 240X
and a 240Z. Both will freeze after a while if I don't run apmd.

The Thinkpad works better under Linux than Windows98!

Jeff


