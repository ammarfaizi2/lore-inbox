Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVAFDw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVAFDw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 22:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVAFDw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 22:52:29 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:21008 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262711AbVAFDwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 22:52:14 -0500
Date: Thu, 6 Jan 2005 11:52:07 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Rik van Riel <riel@redhat.com>
cc: Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
In-Reply-To: <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0501061148480.3537@wombat.indigo.net.au>
References: <1697129508.20050102210332@dns.toxicfilms.tv>
 <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl>
 <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-102.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2005, Rik van Riel wrote:

Oh so true.

> On Sun, 2 Jan 2005, Andries Brouwer wrote:
> 
> > You change some stuff. The bad mistakes are discovered very soon.
> > Some subtler things or some things that occur only in special
> > configurations or under special conditions or just with
> > very low probability may not be noticed until much later.
> 
> Some of these subtle bugs are only discovered a year

Or longer and it doesn't need to be a large system.

> after the distribution with some particular kernel has
> been deployed - at which point the kernel has moved on
> so far that the fix the distro does might no longer
> apply (even in concept) to the upstream kernel...
> 
> This is especially true when you are talking about really
> big database servers and bugs that take weeks or months
> to trigger.

And it doesn't have to be large and complex just infrequently hit code 
path.

This happens much more frequently than anyone wants but that's the the 
way it is.

Ian
