Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWDTNJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWDTNJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbWDTNJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:09:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:6085 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750870AbWDTNJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:09:19 -0400
Date: Thu, 20 Apr 2006 08:09:17 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: grundig <grundig@teleline.es>
Cc: Crispin Cowan <crispin@novell.com>, ak@suse.de, arjan@infradead.org,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060420130917.GF18604@sergelap.austin.ibm.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <p73mzeh2o38.fsf@bragg.suse.de> <20060420011037.6b2c5891.grundig@teleline.es> <200604200138.00857.ak@suse.de> <4446E4AE.1090901@novell.com> <20060420150001.25eafba0.grundig@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420150001.25eafba0.grundig@teleline.es>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting grundig (grundig@teleline.es):
> El Wed, 19 Apr 2006 18:32:30 -0700,
> Crispin Cowan <crispin@novell.com> escribi?:
> 
> > Our controls on changing the name space have rather poor granularity at
> > the moment. We hope to improve that over time, and especially if LSM
> > evolves to permit it. This is ok, because as Andi pointed out, there are
> > currently few applications using name spaces, so we have time to improve
> > the granularity.
> 
> Wouldn't have more sense to improve it and then submit it instead of the
> contrary? At least is the rule which AFAIK is applied to every feature 
> going in the kernel, specially when there's an available alternative
> which users can use meanwhile (see reiser4...)

hah, that's funny

When people do that, they are rebuked for not submitting upstream.  At
least this way, we can have a discussion about whether the approach
makes sense at all.

-serge
