Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTJaQmJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 11:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263423AbTJaQmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 11:42:09 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:64140 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263408AbTJaQmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 11:42:07 -0500
Date: Fri, 31 Oct 2003 17:40:57 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Robert Love <rml@tech9.net>
cc: Jakob Oestergaard <jakob@unthought.net>,
       Maciej Zenczykowski <maze@cela.pl>, Dave Brondsema <dave@brondsema.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: uptime reset after about 45 days
In-Reply-To: <Pine.LNX.4.53.0310311621010.794@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.53.0310311735030.3058@gockel.physik3.uni-rostock.de>
References: <1067552357.3fa18e65d1fca@secure.solidusdesign.com>
 <Pine.LNX.4.44.0310310005090.11473-100000@gaia.cela.pl>
 <20031031103723.GE10792@unthought.net> <Pine.LNX.4.53.0310311621010.794@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003, Tim Schmielau wrote:

> So either apply
>   http://www.physik3.uni-rostock.de/tim/kernel/2.4/jiffies64-21.patch.gz
> as well, or don't patch at all.

... or just apply the combined patch to save you from fixing a few rejects 
by hand.

Robert, would you mind placing the combined patch beside the variable-HZ
patch in your kernel.org directory, to save the cluel^W unaware?

Thanks,
Tim
