Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVKJMls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVKJMls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbVKJMls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:41:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:29585 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750815AbVKJMlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:41:47 -0500
Date: Thu, 10 Nov 2005 12:41:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
Message-ID: <20051110124143.GA10735@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Beulich <JBeulich@novell.com>, Jeff Garzik <jgarzik@pobox.com>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <43720DAE.76F0.0078.0@novell.com> <43722AFC.4040709@pobox.com> <Pine.LNX.4.58.0511090904320.4001@shark.he.net> <43723C6D.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43723C6D.76F0.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 06:14:05PM +0100, Jan Beulich wrote:
> >At a quick blush, I would guess it has as much chance as
> >kdb does (or did) for merging.
> 
> The intention isn't necessarily to merge the whole debugger, but what
> we desire is to merge everything to allow the debugger to be built
> outside of the tree (perhaps as a standalong module).

While you're posted a few actually useful patches that fix or encehance
core code we're not going to put in any of your odd hooks or exports.
As you might have noticed while reading lkml we are everything but keen
on those.

