Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268307AbTBMV3I>; Thu, 13 Feb 2003 16:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268308AbTBMV3F>; Thu, 13 Feb 2003 16:29:05 -0500
Received: from havoc.daloft.com ([64.213.145.173]:32714 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268307AbTBMV3D>;
	Thu, 13 Feb 2003 16:29:03 -0500
Date: Thu, 13 Feb 2003 16:38:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Paul Larson <plars@linuxtestproject.org>
Cc: John Bradford <john@grabjohn.com>, davej@codemonkey.org.uk,
       edesio@ieee.org, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, edesio@task.com.br
Subject: Re: 2.5.60 cheerleading...
Message-ID: <20030213213850.GA22037@gtf.org>
References: <200302131823.h1DINeZh016257@darkstar.example.net> <1045170999.28493.57.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045170999.28493.57.camel@plars>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 03:16:29PM -0600, Paul Larson wrote:
> Ideally, there should be no waiting around for replies.  The message is
> sent, he starts whatever build/boot test cycle, checks for replies when
> he's done and ready to release.  If nothing looks urgent enough to hold
> it up, then he pushes the release.  I still don't see how this adds any
> kind of terrible delay.

Outside suggestions to "improve" Linus's workflow usually fall upon deaf
ears...

IMO to accomplish your goals, set up a test box with BitKeeper,
constantly pulling and testing the latest 2.5.x BK trees.  If they
crash, send full info to lkml.

Enough crash messages, and people will know automatically whether or not
the kernel is good... and Linus didn't have to be bothered at all.

	Jeff




