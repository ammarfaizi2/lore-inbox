Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267753AbTAMBwK>; Sun, 12 Jan 2003 20:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267754AbTAMBwK>; Sun, 12 Jan 2003 20:52:10 -0500
Received: from pcp01184434pcs.strl301.mi.comcast.net ([68.60.187.197]:15843
	"EHLO mythical") by vger.kernel.org with ESMTP id <S267753AbTAMBwJ>;
	Sun, 12 Jan 2003 20:52:09 -0500
Date: Sun, 12 Jan 2003 21:00:51 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113020051.GI12020@michonline.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <200301122306.14411.oliver@neukum.name> <1042410145.3162.152.camel@RobsPC.RobertWilkens.com> <200301122343.41150.oliver@neukum.name> <1042411916.1209.181.camel@RobsPC.RobertWilkens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042411916.1209.181.camel@RobsPC.RobertWilkens.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 05:51:57PM -0500, Rob Wilkens wrote:
> On Sun, 2003-01-12 at 17:43, Oliver Neukum wrote:
> > It's code that causes added hardship for anybody checking the locking.
> 
> I can certainly see where it would seem "easier" to match "one lock" to
> "one unlock" if your troubleshooting a locking issue.
> 
> "easier" is the motivation behind using goto.. Laziness.. that's all it
> is.

Have you ever read "Programming Perl"?

Laziness is a virtue.  (At least I think that's the right book -
possibly the 3rd edition.)

-- 

Ryan Anderson
  sometimes Pug Majere
