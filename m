Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUH1VUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUH1VUP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUH1VQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:16:55 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:27915 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267926AbUH1VNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:13:47 -0400
Date: Sat, 28 Aug 2004 22:13:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm Kconfig fixes
Message-ID: <20040828221345.A11901@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408280309.i7S39PPv000756@hera.kernel.org> <20040828210533.GD6301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040828210533.GD6301@redhat.com>; from davej@redhat.com on Sat, Aug 28, 2004 at 10:05:33PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:05:33PM +0100, Dave Jones wrote:
> Even if not,  I think I'd actually prefer a whitelist of drivers that *do*
> support agpgart in the Kconfig, than the above which needs to be added to
> all the time.  Something like if X86 && ALPHA && IA64 should cover it currently.

PPC

