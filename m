Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWAPMcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWAPMcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWAPMcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:32:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51133 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750742AbWAPMcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:32:18 -0500
Date: Mon, 16 Jan 2006 12:32:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] use usual call trace format on x86-64
Message-ID: <20060116123216.GA13248@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Akinobu Mita <mita@miraclelinux.com>,
	linux-kernel@vger.kernel.org
References: <20060116121611.GA539@miraclelinux.com> <20060116121800.GC539@miraclelinux.com> <200601161322.41633.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601161322.41633.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 01:22:41PM +0100, Andi Kleen wrote:
> On Monday 16 January 2006 13:18, Akinobu Mita wrote:
> > Use print_symbol() to dump call trace.
> 
> Rejected.

Why?  This is a lot more readable than what's there, and similar to other
architectures.

