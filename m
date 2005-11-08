Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965270AbVKHTNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbVKHTNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 14:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbVKHTNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 14:13:21 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54973 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965270AbVKHTNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 14:13:20 -0500
Date: Tue, 8 Nov 2005 19:13:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete SCSI qlogicisp driver
Message-ID: <20051108191310.GA23922@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051108182527.GC3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108182527.GC3847@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 07:25:27PM +0100, Adrian Bunk wrote:
> The SCSI qlogicisp driver is both marked BROKEN and superseded by the 
> qla1280 driver.

It's already gone in the scsi-misc tree.

