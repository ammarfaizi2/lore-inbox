Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWHaFfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWHaFfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 01:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWHaFfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 01:35:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:21153 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750952AbWHaFfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 01:35:32 -0400
X-Authenticated: #14349625
Subject: Re: A nice CPU resource controller
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: balbir@in.ibm.com, Martin Ohlin <martin.ohlin@control.lth.se>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44F671BE.6000607@bigpond.net.au>
References: <44F5AB45.8030109@control.lth.se>
	 <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
	 <44F6365A.8010201@bigpond.net.au>
	 <1157007190.6035.14.camel@Homer.simpson.net>
	 <44F671BE.6000607@bigpond.net.au>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 07:44:41 +0000
Message-Id: <1157010281.18561.26.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-31 at 15:21 +1000, Peter Williams wrote:
> Mike Galbraith wrote:
> > On Thu, 2006-08-31 at 11:07 +1000, Peter Williams wrote:
> > 
> >> But your implication here is valid.  It is better to fiddle with the 
> >> dynamic priorities than with nice as this leaves nice for its primary 
> >> purpose of enabling the sysadmin to effect the allocation of CPU 
> >> resources based on external considerations.
> > 
> > I don't understand.  It _is_ the administrator fiddling with nice based
> > on external considerations.  It just steadies the administrator's hand.
> 
> Not exactly.  If "nice" is being (automatically) fiddled to meet some 
> measurable requirement such as the amount of CPU tasks get it is no 
> longer available as a means for the indication of the relative 
> importance of the tasks.

Yeah, I thought about that meanwhile, see other reply.

	-Mike

