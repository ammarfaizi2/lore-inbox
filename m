Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263073AbVAFXOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbVAFXOD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVAFXJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:09:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:7583 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263073AbVAFXEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:04:51 -0500
Date: Thu, 6 Jan 2005 15:08:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: ak@muc.de, stevel@mvista.com, hugh@veritas.com, raybry@sgi.com,
       clameter@sgi.com, taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: page migration patchset
Message-Id: <20050106150842.27b4c97f.akpm@osdl.org>
In-Reply-To: <20050106223046.GB9636@holomorphy.com>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain>
	<41DC7EAD.8010407@mvista.com>
	<20050106144307.GB59451@muc.de>
	<20050106223046.GB9636@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> There is a relatively consistent pattern of my being steamrolled over
> I'm rather sick of.

That's news to me.

I do recall some months ago that there were a whole bunch of patches doing
a whole bunch of stuff and I was concerned that there was an absence of a
central coordinating role.  But then everything went quiet.

If you have time/inclination to marshall the hugetlb efforts then for
heavens sake, send in a MAINTAINERS record and let's roll the sleeves up.

> and I've apparently
> already been circumvented by pushing the things to distros anyway.

aaargh.  A pox upon the people who did that.  Well if they find their
upstream later breaks things then tough luck.

Look.  All interested parties should subscribe to linux-mm
(majordomo@kvack.org).  Let's get all the patches on the table there and
work through them, asap.  We know how do this.
