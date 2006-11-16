Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424744AbWKPWVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424744AbWKPWVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424747AbWKPWVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:21:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:8163 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1424744AbWKPWVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:21:47 -0500
Date: Thu, 16 Nov 2006 14:22:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Jones <davej@redhat.com>, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/30] -stable review
Message-ID: <20061116222245.GH1397@sequoia.sous-sol.org>
References: <20061116024332.124753000@sous-sol.org> <20061116215735.GH3983@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116215735.GH3983@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> On Wed, Nov 15, 2006 at 06:43:32PM -0800, Chris Wright wrote:
>  > This is the start of the stable review cycle for the 2.6.18.3 release.
>  > There are 30 patches in this series, all will be posted as a response to
>  > this one.  If anyone has any issues with these being applied, please let
>  > us know.  If anyone is a maintainer of the proper subsystem, and wants
>  > to add a Signed-off-by: line to the patch, please respond with it.
>  > 
>  > These patches are sent out with a number of different people on the
>  > Cc: line.  If you wish to be a reviewer, please email stable@kernel.org
>  > to add your name to the list.  If you want to be off the reviewer list,
>  > also email us.
>  > 
>  > Responses should be made by Sat Nov 18 02:35 UTC.  Anything received
>  > after that time might be too late.
> 
> No handy -pre rollup this time ?

Hmm, no, although just by lack of pushnig it.  I've now also pushed
an rc2 (dropped one patch already), not sure how long it will take to
mirror out, however, since k.o is pretty slammed right now.

http://kernel.org/pub/linux/kernel/people/chrisw/stable/

thanks,
-chris
