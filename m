Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269147AbUIHN5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269147AbUIHN5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUIHNoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:44:00 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:7915 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268049AbUIHNmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:42:43 -0400
Date: Wed, 8 Sep 2004 09:47:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Scott Wood <scott@timesys.com>
Subject: Re: [patch] generic-hardirqs.patch, 2.6.9-rc1-bk14
In-Reply-To: <20040908143143.A32002@infradead.org>
Message-ID: <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com>
References: <20040908120613.GA16916@elte.hu> <20040908133445.A31267@infradead.org>
 <20040908124547.GA19231@elte.hu> <20040908125755.GC3106@holomorphy.com>
 <Pine.LNX.4.53.0409080932050.15087@montezuma.fsmlabs.com>
 <20040908143143.A32002@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Christoph Hellwig wrote:

> On Wed, Sep 08, 2004 at 09:34:03AM -0400, Zwane Mwaikambo wrote:
> > Hmm, whenever i've brought up weak functions in a patch it's never well 
> > received. Frankly i prefer it to littering the architectures with similar 
> > functions.
> 
> That's what we have asm-generic for.

So you have an inline function in a header and include it everywhere? How 
is that better?

	Zwane
