Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTJQUN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 16:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTJQUN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 16:13:28 -0400
Received: from smtp0.libero.it ([193.70.192.33]:22669 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S263515AbTJQUN1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 16:13:27 -0400
Date: Fri, 17 Oct 2003 22:10:30 +0200
From: "M. Fioretti" <m.fioretti@inwind.it>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "M. Fioretti" <m.fioretti@inwind.it>,
       linux-kernel <linux-kernel@vger.kernel.org>, wli <wli@holomorphy.com>
Subject: Re: Unbloating the kernel, action list
Message-ID: <20031017201030.GK4943@inwind.it>
Reply-To: "M. Fioretti" <m.fioretti@inwind.it>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <20031014214311.GC933@inwind.it> <16710000.1066170641@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16710000.1066170641@flay>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 15:30:41 at 03:30:41PM -0700, Martin J. Bligh (mbligh@aracnet.com) wrote:
> 
> > 7) Do come in suggesting anything I might have forgotten
> 
> If you do automated testing of nightly builds of the mainline 2.6 / 2.7
> kernels, and point out when they get bigger in consumption, you'll have
> a much better chance of convincing people to fix it when the patch in
> question is still topical, and fresh in people's minds.

I agree. Unfortunately, I have no possibility to do this. I'll pass it
over to the RULE list, though.

> I'd predict that a lot of the issue is just tuning things dynamically 
> instead of statically sizing them.

That makes sense. From our point of view, the best thing would be
pointers to resources explaining what to tune, when and why, so we can
prepare suitable documentation from that for our non technical end
users. Suggestions?

TIA,
	Marco Fioretti

-- 
Marco Fioretti                 m.fioretti, at the server inwind.it
Red Hat for low memory         http://www.rule-project.org/en/

I doni ricevuti dal Padreterno, servono se utilizzati: chi li contempla
gode, ma chi ne fa uso probabilmente aiuta altri a godere.
