Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVKSWmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVKSWmQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 17:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbVKSWmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 17:42:16 -0500
Received: from isilmar.linta.de ([213.239.214.66]:13267 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1751000AbVKSWmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 17:42:16 -0500
Date: Sat, 19 Nov 2005 23:42:10 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
Message-ID: <20051119224210.GA3671@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com> <Pine.LNX.4.61.0511182214200.4797@goblin.wat.veritas.com> <Pine.LNX.4.61.0511191950100.2846@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511191950100.2846@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 07:57:02PM +0000, Hugh Dickins wrote:
> So I'll go on a trawl through the source before finalizing the fix,
> but below is the patch you guys need.  Does this patch deal with your
> Bad page states too, Marc?  Does it help your mouse at all somehow?

Works for me.

Thanks,
	Dominik
