Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWHUVps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWHUVps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWHUVps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:45:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:28379 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751203AbWHUVpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:45:47 -0400
Date: Mon, 21 Aug 2006 14:43:49 -0700
From: Greg KH <gregkh@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/20] 2.6.17-stable review
Message-ID: <20060821214349.GA1885@suse.de>
References: <20060821184527.GA21938@kroah.com> <20060821194616.GC12928@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821194616.GC12928@redhat.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 03:46:16PM -0400, Dave Jones wrote:
> On Mon, Aug 21, 2006 at 11:45:27AM -0700, Greg KH wrote:
>  > This is the start of the stable review cycle for the next 2.6.17.y
>  > release.  There are 20 patches in this series, all will be posted as
>  > a response to this one.  If anyone has any issues with these being
>  > applied, please let us know.  If anyone is a maintainer of the proper
>  > subsystem, and wants to add a Signed-off-by: line to the patch, please
>  > respond with it.
>  > 
>  > These patches are sent out with a number of different people on the Cc:
>  > line.  If you wish to be a reviewer, please email stable@kernel.org to
>  > add your name to the list.  If you want to be off the reviewer list,
>  > also email us.
> 
> Any chance of a 2.6.17.10-rc1 rollup patch again, like you did for .8?

Oops, forgot to do that, thanks for reminding me.  It can be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.17.10-rc1.gz

And yes, it's not in the "main" v2.6 subdirectories, I'm not going to
put it there anymore as it confuses too many scripts/people.

thanks,

greg k-h
