Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263083AbRFFHSS>; Wed, 6 Jun 2001 03:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263086AbRFFHSI>; Wed, 6 Jun 2001 03:18:08 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:55044 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S263083AbRFFHRu>; Wed, 6 Jun 2001 03:17:50 -0400
Date: Wed, 6 Jun 2001 08:14:16 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Russell Leighton <russell.leighton@247media.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606081416.B15199@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Russell Leighton <russell.leighton@247media.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com> <3B1D8A82.63FA138C@247media.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B1D8A82.63FA138C@247media.com>; from russell.leighton@247media.com on Tue, Jun 05, 2001 at 09:42:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 09:42:26PM -0400, Russell Leighton wrote:
> 
> I also need some 2.4 features and can't really goto 2.2.
> I would have to agree that the VM is too broken for production...looking
> forward to the work that (hopefully) will be in 2.4.6 to resolve these issues.
> 

Boring to do a "me too", but "me too".  We have four big production oracle
servers that could use 2.4 .  However, the test server we have put 2.4 on has
no end of ridiculous VM and OOM problems.

It seems bizarre that a 4GB machine with a working set _far_ lower than that
should be dying from OOM and swapping itself to death, but that's life in 2.4
land.


Sean
