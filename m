Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbVBIJP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbVBIJP2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 04:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbVBIJP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 04:15:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61402 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261613AbVBIJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 04:14:34 -0500
Date: Wed, 9 Feb 2005 09:14:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Michael Renzmann <mrenzmann@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to retrieve version from kernel source (the right way)?
Message-ID: <20050209091433.GA11690@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Renzmann <mrenzmann@web.de>, linux-kernel@vger.kernel.org
References: <4209C71F.9040102@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4209C71F.9040102@web.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 09:17:35AM +0100, Michael Renzmann wrote:
> Hi all.
> 
> (Please CC: me, I'm not subscribed - although I'm following the list 
> through gmane.org)
> 
> I'm working on Madwifi (a driver for wireless lan cards with Atheros 
> chipset), which isn't part of the kernel (and probably won't ever be due 
> to the binary-only HAL).

Why don't you use the reverse-engineered HAL from OpenBSD?

