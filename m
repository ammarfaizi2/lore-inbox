Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbTDRSot (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTDRSot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:44:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:61452 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263207AbTDRSop
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:44:45 -0400
Date: Fri, 18 Apr 2003 14:51:47 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.67-ac2
In-Reply-To: <200304180827.40934@gandalf>
Message-ID: <Pine.LNX.3.96.1030418145057.10513B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Apr 2003, Rudmer van Dijk wrote:

> On Friday 18 April 2003 01:19, Alan Cox wrote:
> > Next set of updates. Cautionary words still appy.
> > 
> > Handle with care, no naked flames, do not inhale....
> 
> It compiles, but it does not boot:
> kernel panic: cannot find init
> 
> this is with devfs enabled and mounted at boot.
> I can't find anything in the lists although I thought I saw someone reporting 
> a similar problem.
> will try it without devfs

Let us know, my memory is that Alan doesn't use devfs and it's "lightly
tested" if I remember his term.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

