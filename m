Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUGIOKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUGIOKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 10:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUGIOKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 10:10:09 -0400
Received: from [213.146.154.40] ([213.146.154.40]:64940 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264727AbUGIOJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 10:09:57 -0400
Date: Fri, 9 Jul 2004 15:09:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bastian Blank <bastian@waldi.eu.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 - mark IPv6 support for QETH as broken
Message-ID: <20040709140947.GA32405@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bastian Blank <bastian@waldi.eu.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20040709140630.GA27350@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709140630.GA27350@wavehammer.waldi.eu.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 04:06:30PM +0200, Bastian Blank wrote:
> Hi Andrew
> 
> The attached patch marks IPv6 support for QETH broken, it is known to
> need an extra patch to compile which was submitted one year ago but
> never accepted.

If it doesn't even compile BROKEN isn't enough.  In that case cometely
uncomment the option in Kconfig.

