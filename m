Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271014AbUJVKVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271014AbUJVKVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271013AbUJVKVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:21:05 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:267 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271014AbUJVKVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:21:03 -0400
Date: Fri, 22 Oct 2004 11:21:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bill Huey <bhuey@lnxw.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041022102103.GA17526@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bill Huey <bhuey@lnxw.com>, LKML <linux-kernel@vger.kernel.org>
References: <20041021095344.GA10531@suse.de> <1098352441.26758.30.camel@thomas> <20041021101103.GC10531@suse.de> <20041021195842.GA23864@nietzsche.lynx.com> <20041021201443.GF32465@suse.de> <20041021202422.GA24555@nietzsche.lynx.com> <20041021203350.GK32465@suse.de> <20041021203821.GA24628@nietzsche.lynx.com> <20041022061901.GM32465@suse.de> <20041022085007.GA24444@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022085007.GA24444@nietzsche.lynx.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 01:50:07AM -0700, Bill Huey wrote:
> On Fri, Oct 22, 2004 at 08:19:01AM +0200, Jens Axboe wrote:
> > It has to go, why? Because your deadlock detection breaks? Doesn't seem
> > a very strong reason to me at all, sorry.
> 
> The deadlock detector is needed. Whether you understand that or not is
> irrelevant to the current work that's being done. And your idiot attacks
> against it doesn't correct these issues nor does it gain credibility
> with the audience that does find it useful.

*plonk*

