Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVCJR4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVCJR4I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVCJRvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:51:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:26596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262771AbVCJRoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:44:07 -0500
Date: Thu, 10 Mar 2005 09:43:59 -0800
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg KH <greg@kroah.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] -stable, how it's going to work.
Message-ID: <20050310174359.GP5389@shell0.pdx.osdl.net>
References: <20050309072833.GA18878@kroah.com> <16944.6867.858907.990990@cse.unsw.edu.au> <20050310164312.GC16126@kroah.com> <1110475644.12805.43.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110475644.12805.43.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Thu, 2005-03-10 at 08:43 -0800, Greg KH wrote:
> > That, and a zillion other specific wordings that people suggested fall
> > under the:
> > 	or some "oh, that's not good" issue
> > rule.
> 
> So just to be 100% clear, no sound with 2.6.N where the sound worked
> with 2.6.N-1 absolutely does qualify.  Right?

Depends, is listening to music while you work critical...? j/k ;-)
Yeah, that's a driver regression...used to work, now it's broken.
If fix is back out all changes, that's not so nice, if it's a
'one-liner' then definitely.  Have a concrete example and patch?

thanks
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
