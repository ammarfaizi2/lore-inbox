Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVCJSPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVCJSPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 13:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVCJSLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 13:11:01 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:57299 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262791AbVCJRv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:51:58 -0500
Subject: Re: [RFC] -stable, how it's going to work.
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <greg@kroah.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050310174359.GP5389@shell0.pdx.osdl.net>
References: <20050309072833.GA18878@kroah.com>
	 <16944.6867.858907.990990@cse.unsw.edu.au>
	 <20050310164312.GC16126@kroah.com> <1110475644.12805.43.camel@mindpipe>
	 <20050310174359.GP5389@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 12:51:48 -0500
Message-Id: <1110477109.12805.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 09:43 -0800, Chris Wright wrote:
> * Lee Revell (rlrevell@joe-job.com) wrote:
> > On Thu, 2005-03-10 at 08:43 -0800, Greg KH wrote:
> > > That, and a zillion other specific wordings that people suggested fall
> > > under the:
> > > 	or some "oh, that's not good" issue
> > > rule.
> > 
> > So just to be 100% clear, no sound with 2.6.N where the sound worked
> > with 2.6.N-1 absolutely does qualify.  Right?
> 
> Depends, is listening to music while you work critical...? j/k ;-)
> Yeah, that's a driver regression...used to work, now it's broken.
> If fix is back out all changes, that's not so nice, if it's a
> 'one-liner' then definitely.  Have a concrete example and patch?

Not yet.  We are still trying to figure out whether 2.6.11 introduced an
ALSA regression or not.  See the "intel 8x0 went silent" thread.

Lee

