Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTDPLco (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 07:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTDPLco 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 07:32:44 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id S264301AbTDPLcn 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 07:32:43 -0400
Date: Tue, 15 Apr 2003 07:17:09 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Larry McVoy <lm@work.bitmover.com>, Andrew Morton <akpm@digeo.com>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org,
       Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.5 io statistics?
Message-ID: <20030415051709.GA2031@zaurus.ucw.cz>
References: <20030408155858.GB27912@work.bitmover.com> <20030408152215.00b7beca.akpm@digeo.com> <20030409013700.GA4650@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030409013700.GA4650@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
> > > 0.00  19M 562M  48M 4.0K   12K   0   0   0   0  137   25  267   83    0   0 100
> > 
> > It's currently undergoing a bit of change.
> 
> Well, one question is this: I'd like to be able to get at a list of disk stats
> sorted by activity.  If you noticed, the output above reserved space for 4
> drives.  I know it's not general at all, but it would be nice to somehow be
> able to get at the "busy" drives.  I don't have any ideas on how to do this

Perhaps top-3 then sum of rest is better
idea (perhaps you do that already...)

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

