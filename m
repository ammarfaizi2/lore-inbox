Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbUKOGwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbUKOGwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUKOGue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:50:34 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:23566 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261539AbUKOGs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:48:27 -0500
Date: Mon, 15 Nov 2004 06:48:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI initio.c: some cleanups
Message-ID: <20041115064819.GA12863@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20041115020949.GN2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115020949.GN2249@stusta.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 03:09:49AM +0100, Adrian Bunk wrote:
> The patch below does the following cleanups:
> - make some needlessly global code static
> - remove the unused global function tul_pop_pend_scb
> 
> Please review and apply if it's correct.

Good idea, but this clashes with a function change I have pending.
Please redo it in a week or two ;-)

