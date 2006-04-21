Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWDURas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWDURas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 13:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWDURas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 13:30:48 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22912 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751190AbWDURar
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 13:30:47 -0400
Date: Fri, 21 Apr 2006 10:30:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris Wright <chrisw@sous-sol.org>, Arjan van de Ven <arjan@infradead.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060421173008.GB3061@sorel.sous-sol.org>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <1145470463.3085.86.camel@laptopd505.fenrus.org> <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org> <20060420192717.GA3828@sorel.sous-sol.org> <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145621926.21749.29.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> Difficult to evaluate, when the answer whenever a flaw is pointed out is
> "that's not in our threat model."  Easy enough to have a protection
> model match the threat model when the threat model is highly limited
> (and never really documented anywhere, particularly in a way that might
> warn its users of its limitations).

I know, there's two questions.  Whether the protection model is valid,
and whether the threat model is worth considering.  So far, I've not
seen anything that's compelling enough to show AppArmor fundamentally
broken.  Ugly and inefficient, yes...broken, not yet.

thanks,
-chris
