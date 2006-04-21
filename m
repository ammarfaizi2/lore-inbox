Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWDUWKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWDUWKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWDUWKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:10:18 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41376 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751370AbWDUWKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:10:17 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Matt Helsley <matthltc@us.ibm.com>
To: Al Boldi <a1426z@gawab.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200604212207.44266.a1426z@gawab.com>
References: <200604212207.44266.a1426z@gawab.com>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 15:04:08 -0700
Message-Id: <1145657048.21109.583.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 22:07 +0300, Al Boldi wrote:
> Chandra Seetharaman wrote:
> > On Fri, 2006-04-21 at 07:49 -0700, Dave Hansen wrote:
> > > On Thu, 2006-04-20 at 19:24 -0700, sekharan@us.ibm.com wrote:
> > > > CKRM has gone through a major overhaul by removing some of the
> > > > complexity, cutting down on features and moving portions to userspace.
> > >
> > > What do you want done with these patches?  Do you think they are ready
> > > for mainline?  -mm?  Or, are you just posting here for comments?
> >
> > We think it is ready for -mm. But, want to go through a review cycle in
> > lkml before i request Andrew for that.
> 
> IMHO, it would be a good idea to decouple the current implementation and 
> reconnect them via an open mapper/wrapper to allow a more flexible/open 
> approach to resource management, which may ease its transition into 
> mainline, due to a step-by-step instead of an all-or-none approach.
> 
> Thanks!
> 
> --
> Al

Hi Al,

	I'm sorry, I don't understand what you're suggesting. Could you please
elaborate on how you think it should be decoupled?

Thanks,
	-Matt Helsley

