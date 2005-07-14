Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263123AbVGNTxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263123AbVGNTxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263133AbVGNTw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:52:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13761 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263123AbVGNTvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:51:33 -0400
Date: Thu, 14 Jul 2005 20:51:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: ericvh@gmail.com
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc2-mm2 7/7] v9fs: debug and support routines (2.0.2)
Message-ID: <20050714195132.GB22576@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, ericvh@gmail.com,
	linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
	akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <200507141830.j6EIUue1020761@ms-smtp-02-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507141830.j6EIUue1020761@ms-smtp-02-eri0.texas.rr.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 08:53:59AM -0500, ericvh@gmail.com wrote:
> This is part [7/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2.
> 
> This part of the patch contains debug and other misc routine changes related
> to hch's comments.

Here a few if( instead if ( formatting sneaked in.

