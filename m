Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbVD3CoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbVD3CoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 22:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbVD3CoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 22:44:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:18583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263134AbVD3CoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 22:44:03 -0400
Date: Fri, 29 Apr 2005 19:43:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg KH <gregkh@suse.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] Re: Linux 2.6.11.8
Message-ID: <20050430024351.GC493@shell0.pdx.osdl.net>
References: <20050430015732.GA8943@kroah.com> <1114826678.8636.15.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114826678.8636.15.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2005-04-29 at 18:57 -0700, Greg KH wrote:
> > As the -stable patch review cycle is now over, I've released the
> > 2.6.11.8 kernel in the normal kernel.org places.  Due to some
> > disagreement over some of the patches in the review cycle, I've dropped
> > a number of them.
> 
> Why didn't the fix for losing the keyboard when unplugging a USB audio
> device go in?  That was a serious bug that bit many, many users.

They came in while we were already in the review process.  They'll have
to be queued for next review cycle.

thanks,
-chris
