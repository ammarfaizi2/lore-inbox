Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUGVPDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUGVPDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGVPDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:03:21 -0400
Received: from [213.146.154.40] ([213.146.154.40]:37353 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266208AbUGVPDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:03:14 -0400
Date: Thu, 22 Jul 2004 16:03:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: 2.6.7 oops, sk98lin related?
Message-ID: <20040722150314.GB13195@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bernd Schubert <bernd-schubert@web.de>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200407221101.16388.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407221101.16388.bernd-schubert@web.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 11:01:14AM +0200, Bernd Schubert wrote:
> Hello Christoph and all others,
> 
> is this an sk98lin oops, maybe related to your patches or is it a completely 
> different problem?

I don't think there's skge patches from me in 2.6.7 yet, but certainly not
in that area ;-)

This is just a big memory allocation failing, not an oops anyway.

