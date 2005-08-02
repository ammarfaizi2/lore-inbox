Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVHBTV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVHBTV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVHBTV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:21:26 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:58274 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261695AbVHBTVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:21:24 -0400
Subject: Re: Testing RC kernels [KORG]
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: webmaster@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Sean Bruno <sean.bruno@dsl-only.net>
In-Reply-To: <1123008881.12562.16.camel@mindpipe>
References: <1123007589.24010.41.camel@jy.metro1.com>
	 <1123007777.12562.11.camel@mindpipe>
	 <1123007814.24010.45.camel@jy.metro1.com>
	 <1123008881.12562.16.camel@mindpipe>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 02 Aug 2005 15:21:05 -0400
Message-Id: <1123010465.1590.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 14:54 -0400, Lee Revell wrote:
> On Tue, 2005-08-02 at 11:36 -0700, Sean Bruno wrote:
> > On Tue, 2005-08-02 at 14:36 -0400, Lee Revell wrote:
> > > On Tue, 2005-08-02 at 11:33 -0700, Sean Bruno wrote:
> > > > <noob question>
> > > > 
> > > > I have been trying to test the 2.6.13 and can't quite get the patches
> > > > applied cleanly.
> > > > 
> > > > What kernel version (full kernel source tar ball) should I be using to
> > > > apply the patches(rc5) with?  Is it 2.6.12.3?
> > > 
> > > No, 2.6.12.
> > > 
> > > Lee
> > > 
> > 
> > Ah!  Thanks.
> 
> Thanks for testing the RCs, we need more users to do that.
> 
> If any of your hardware stops working, make sure to report it, don't
> assume that it will fix itself!  Assume you're the first to notice the
> bug.

I've been complaining about this for some time. Kernel.org really needs
to show more information about the rc kernels and how to create them.
We want more testers, but I wonder how many people go through the above
steps and just give up when things don't work. Luckly Sean was nice
enough to email the LKML and ask.

My main gripe is that there's no link to 2.6.12 which is what most of
the other patches go against.

-- Steve


