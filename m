Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWDTT16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWDTT16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWDTT16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:27:58 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7553 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750934AbWDTT15
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:27:57 -0400
Date: Thu, 20 Apr 2006 12:27:17 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060420192717.GA3828@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145522524.3023.12.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> On Thu, 2006-04-20 at 00:32 +0200, Andi Kleen wrote:
> > Arjan van de Ven <arjan@infradead.org> writes:
> > > 
> > > you must have a good defense against that argument, so I'm curious to
> > > hear what it is
> > 
> > [I'm not from the apparmor people but my understanding is]
> > 
> > Usually they claimed name spaces as the reason it couldn't work.
> 
> I actually posted a list of 10 things that I made up in 3 minutes; just
> going over those 10 would be a good start already since they're the most
> obvious ones..

Yes, the conversation is all over the place.  Many of the issues are
about some of the uglier parts of the AppArmor code, but the critical
issue is simple.  Does their protection model actually protect against
their threat model.  I would really like to see some grounded examples
that show whether it's broken or not.

thanks,
-chris
