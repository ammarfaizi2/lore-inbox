Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVA0VMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVA0VMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVA0VL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:11:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16849 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261200AbVA0VHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:07:37 -0500
Date: Thu, 27 Jan 2005 21:07:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Netdev <netdev@oss.sgi.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100, xircom_tulip_cb, iph5526
Message-ID: <20050127210731.GA2953@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Netdev <netdev@oss.sgi.com>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>
References: <41F952F4.7040804@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F952F4.7040804@pobox.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 03:45:40PM -0500, Jeff Garzik wrote:
> 1) iphase (iph5526 a.k.a. drivers/net/fc/*)
> 
> Been broken since 2.3 or 2.4.  Only janitors have kept it compiling.

No, it doesn't even compile, and didn't so for more than two years.

