Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280994AbRKYTDz>; Sun, 25 Nov 2001 14:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280997AbRKYTDq>; Sun, 25 Nov 2001 14:03:46 -0500
Received: from c1603961-a.bvrtn1.or.home.com ([65.12.251.105]:47749 "EHLO
	water.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S280994AbRKYTDh>; Sun, 25 Nov 2001 14:03:37 -0500
From: Nathan Dabney <smurf@osdlab.org>
Date: Sun, 25 Nov 2001 11:03:15 -0800
To: Keith Owens <kaos@ocs.com.au>
Cc: Nathan Dabney <smurf@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases
Message-ID: <20011125110315.A17688@osdlab.org>
In-Reply-To: <20011125012507.C6414@osdlab.org> <12023.1006683861@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12023.1006683861@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 09:24:21PM +1100, Keith Owens wrote:
> On Sun, 25 Nov 2001 01:25:07 -0800, 
> Nathan Dabney <smurf@osdlab.org> wrote:
> >We will be running all the available tests (until that list gets too large
> >to be possible) on each kernel the morning after it's released.
> 
> Have you been following the kbuild 2.5 developments[1]?  Linus has
> agreed that this change will go in early in the 2.5 cycle, that will
> impact on all automated testing for 2.5.  There will be both good and
> bad impacts, the bad is the initial changeover, the good is a much
> cleaner build process and the ability to build multiple configurations
> from a single source tree.
> 
> [1] http://sourceforge.net/projects/kbuild/

Yes, we will be able to add another method for (auto) kernel configuration when
this becomes an issue (hopefully RSN).

Currently the method we use to "sanitize" submitted kernel configs for our
hardware is as reliable as you can get under CML1.  It doesn't however, give
us a good way to build multiple configurations.

-Nathan
