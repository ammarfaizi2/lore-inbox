Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUIBKQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUIBKQj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUIBKQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:16:39 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:53764 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268121AbUIBKQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:16:38 -0400
Date: Thu, 2 Sep 2004 11:16:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [ppc64] update pSeries_defconfig
Message-ID: <20040902111634.A22852@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Anton Blanchard <anton@samba.org>, akpm@osdl.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
References: <20040902095035.GW26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040902095035.GW26072@krispykreme>; from anton@samba.org on Thu, Sep 02, 2004 at 07:50:35PM +1000
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 07:50:35PM +1000, Anton Blanchard wrote:
> 
> Hi,
> 
> Update pSeries_defconfig. This config should better cover POWER5 systems
> with SPLPAR spinlocks, IPR SCSI, NR_CPUS = 128, NUMA, HVCS, and irq stacks
> enabled, VSCSI and VETH as modules.

BTW, g5_defconfig also needs an update :)

