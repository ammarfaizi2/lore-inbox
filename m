Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266179AbUGVPA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUGVPA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 11:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUGVPA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 11:00:59 -0400
Received: from [213.146.154.40] ([213.146.154.40]:33001 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266179AbUGVPA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 11:00:58 -0400
Date: Thu, 22 Jul 2004 16:00:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Update Marvell Yukon Gigabit NIC driver?
Message-ID: <20040722150057.GA13195@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"H. J. Lu" <hjl@lucon.org>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <20040721194949.GA25030@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721194949.GA25030@lucon.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 12:49:49PM -0700, H. J. Lu wrote:
> The current Marvell Yukon Gigabit NIC driver version 7.04 is at:
> 
> http://www.syskonnect.com/syskonnect/support/driver/d0102_driver.html
> 
> and
> 
> http://www.marvell.com/drivers/search.do
> 
> Are there any plans to integrate it into 2.4 and 2.6 kernel? I can
> generate patches against 2.4 and 2.6 if needed.

Please submit small patches against the driver in Jeff's netdev queue,
and keep all fixes that went into the kernel driver.

