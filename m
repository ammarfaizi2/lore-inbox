Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVD3SRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVD3SRr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 14:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVD3SRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 14:17:46 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:712 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261325AbVD3SRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:17:39 -0400
Subject: Re: Updated realtime-preempt documentation
From: Lee Revell <rlrevell@joe-job.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: mjc@unre.st, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0504300723260.18872-100000@dhcp153.mvista.com>
References: <Pine.LNX.4.44.0504300723260.18872-100000@dhcp153.mvista.com>
Content-Type: text/plain
Date: Sat, 30 Apr 2005 14:17:36 -0400
Message-Id: <1114885056.10415.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-30 at 07:28 -0700, Daniel Walker wrote:
> On Sat, 30 Apr 2005, Lee Revell wrote:
> 
> > 
> > I think it's changing too fast for anyone to have bothered to document
> > it yet.
> 
> That's true for some of it, but like interrupts in threads hasn't changed 
> in a few months .. The config options aren't likely to change .. 
> 

Right now there's this:

http://www.affenbande.org/~tapas/wiki/index.php?Low%20latency%20for%
20audio%20work%20on%20linux%202.6.x

It's slightly outdated and focuses only on using the RT kernel for low
latency audio with JACK, but I think it's the best user level doc so
far.

Lee


