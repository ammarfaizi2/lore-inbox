Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161540AbWJKWA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161540AbWJKWA1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161545AbWJKWA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:00:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:19854 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161540AbWJKWAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:00:25 -0400
Date: Wed, 11 Oct 2006 14:59:43 -0700
From: Greg KH <gregkh@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/67] 2.6.18-stable review
Message-ID: <20061011215943.GA19559@suse.de>
References: <20061011210310.GA16627@kroah.com> <20061011213648.GC32371@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011213648.GC32371@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 05:36:48PM -0400, Dave Jones wrote:
> On Wed, Oct 11, 2006 at 02:03:10PM -0700, Greg KH wrote:
>  > This is the start of the stable review cycle for the 2.6.18.1 release.
>  > There are 67 patches in this series, all will be posted as a response to
>  > this one.  If anyone has any issues with these being applied, please let
>  > us know.  If anyone is a maintainer of the proper subsystem, and wants
>  > to add a Signed-off-by: line to the patch, please respond with it.
>  > 
>  > These patches are sent out with a number of different people on the Cc:
>  > line.  If you wish to be a reviewer, please email stable@kernel.org to
>  > add your name to the list.  If you want to be off the reviewer list,
>  > also email us.
>  > 
>  > Responses should be made by Friday, October 13, 20:00:00 UTC.  Anything
>  > received after that time might be too late.
>  > 
>  > And yes, we realize that this is a large number of patches, sorry, we
>  > have been a bit slow in responding lately.  If there are any patches
>  > that have been sent to us for the 2.6.18-stable tree, that are not in
>  > this series, please resend them, as we think we are finally caught up
>  > with this work.
>  > 
>  > An all-in-one patch for this series can be found at:
>  > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.18.1-rc1.gz
>  > if anyone wants to test this out that way.
> 
> Is it intentional that this adds a include/linux/utsrelease.h ?
> I don't see any patch that adds it in the review mails, but its there in the gz.

Hm, I guess the dontdiff file wasn't updated, as I built and booted out
of that directory, so that is where it came from.  Sorry about that.

Anyone want to update dontdiff?  :)

thanks,

greg k-h
