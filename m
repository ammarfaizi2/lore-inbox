Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbTE2FLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 01:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTE2FLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 01:11:09 -0400
Received: from ip68-111-188-90.sd.sd.cox.net ([68.111.188.90]:33155 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP id S261887AbTE2FLJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 01:11:09 -0400
Date: Wed, 28 May 2003 22:24:25 -0700
From: Marc Wilson <msw@cox.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Message-ID: <20030529052425.GA1566@moonkingdom.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200305291122.20775.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305291122.20775.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 11:22:20AM +1000, Con Kolivas wrote:
> On Thu, 29 May 2003 10:55, Marcelo Tosatti wrote:
> > Andrew Morton <akpm@digeo.com>:
> >   o Fix IO stalls and deadlocks
> 
> For those interested these are patches 1 and 2 from akpm's proposed fixes in 
> the looong thread discussing this problem.

Are you sure?  I'm no C programmer, but it looks to me like all three
patches are in 21-rc6.

And I still see the stalls, although it's much reduced. :(  I just had mutt
freeze cold on me though for ~15 sec when it tried to open my debian-devel
mbox (rather lage file) while brag was beating on the drive.

<whimper>

-- 
 Marc Wilson |     You have had a long-term stimulation relative to
 msw@cox.net |     business.
