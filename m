Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWGKWqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWGKWqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWGKWqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:46:07 -0400
Received: from xenotime.net ([66.160.160.81]:12724 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751340AbWGKWqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:46:05 -0400
Date: Tue, 11 Jul 2006 15:48:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, arjan@infradead.org
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
 keep cache pressure down
Message-Id: <20060711154852.7d03937b.rdunlap@xenotime.net>
In-Reply-To: <1152653719.16499.41.camel@chalcedony.pathscale.com>
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
	<20060711140951.f22847d8.rdunlap@xenotime.net>
	<1152653719.16499.41.camel@chalcedony.pathscale.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 14:35:19 -0700 Bryan O'Sullivan wrote:

> On Tue, 2006-07-11 at 14:09 -0700, Randy.Dunlap wrote:
> 
> > space after commas, please.
> 
> Yep.
> 
> > Currently kernel-doc function description is limited to one line.
> 
> Ugh, OK.  What about "Memory copy, bypassing CPU cache for loads" for
> the one-liner?  And a suitably modified first paragraph to make it clear
> that on some arches, it falls back to memcpy.

Yep, that sounds good.

Thanks.
---
~Randy
