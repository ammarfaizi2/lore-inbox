Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268066AbTBMPow>; Thu, 13 Feb 2003 10:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268067AbTBMPow>; Thu, 13 Feb 2003 10:44:52 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:24750 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S268066AbTBMPov>; Thu, 13 Feb 2003 10:44:51 -0500
Date: Thu, 13 Feb 2003 16:54:32 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Larson <plars@linuxtestproject.org>
Cc: Edesio Costa e Silva <edesio@ieee.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Edesio Costa e Silva <edesio@task.com.br>
Subject: Re: 2.5.60 cheerleading...
Message-ID: <20030213155432.GA30401@wohnheim.fh-wedel.de>
References: <3E4A6DBD.8050004@pobox.com> <1045075415.22295.46.camel@plars> <20030212173300.A31055@master.softaplic.com.br> <1045150153.28493.10.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1045150153.28493.10.camel@plars>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 February 2003 09:29:12 -0600, Paul Larson wrote:
> 
> If Linus really is building and booting every kernel prior to release,
> it would be quick and simple to add a fast subset of LTP to the mix and
> do a quick regression run.  It's convenient, fast and could save a lot
> of headaches for a lot of people later on.

The problem I see with this approach is that "a lot of people" scales
far better than Linus.

Saving 100 people a day of work by offloading it to Linus is quite an
optimisation, but it doesn't optimize the overall development speed.

Let the crowd build the kernel, see the breakage and fix it up, until
we get back to -preX and -rcY kernels.

Jörn

-- 
Victory in war is not repetitious.
-- Sun Tzu
