Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWBTUR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWBTUR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWBTUR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:17:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64911 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161123AbWBTURZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:17:25 -0500
Date: Mon, 20 Feb 2006 20:17:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mark Maule <maule@sgi.com>, akpm@osdl.org
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] altix:  export sn_pcidev_info_get
Message-ID: <20060220201713.GA4992@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Maule <maule@sgi.com>, akpm@osdl.org,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060214162337.GA16954@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214162337.GA16954@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:23:37AM -0600, Mark Maule wrote:
> Export sn_pcidev_info_get.

Tony or Andrew please back this out again.  The only reason SGI wants this is
to support their illegal graphics driver, and no core code uses it.

And Mark, please stop submitting such patches.

