Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVETBGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVETBGF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 21:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVETBGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 21:06:04 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:53397 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261220AbVETBFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 21:05:50 -0400
Subject: Re: [stable] Re: Linux 2.6.11.8
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <gregkh@suse.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
In-Reply-To: <20050430024351.GC493@shell0.pdx.osdl.net>
References: <20050430015732.GA8943@kroah.com>
	 <1114826678.8636.15.camel@mindpipe>
	 <20050430024351.GC493@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 19 May 2005 21:05:49 -0400
Message-Id: <1116551149.23977.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 19:43 -0700, Chris Wright wrote:
> * Lee Revell (rlrevell@joe-job.com) wrote:
> > On Fri, 2005-04-29 at 18:57 -0700, Greg KH wrote:
> > > As the -stable patch review cycle is now over, I've released the
> > > 2.6.11.8 kernel in the normal kernel.org places.  Due to some
> > > disagreement over some of the patches in the review cycle, I've dropped
> > > a number of them.
> > 
> > Why didn't the fix for losing the keyboard when unplugging a USB audio
> > device go in?  That was a serious bug that bit many, many users.
> 
> They came in while we were already in the review process.  They'll have
> to be queued for next review cycle.
> 

It looks like this never went in!  Someone just reported the bug again
on LKML.  What's the deal?

Lee

