Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVCaKWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVCaKWv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVCaKWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:22:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:18403 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261200AbVCaKWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:22:21 -0500
Date: Thu, 31 Mar 2005 11:22:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <htejun@gmail.com>
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 09/13] scsi: in scsi_prep_fn(), remove bogus comments & clean up
Message-ID: <20050331102217.GE13842@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <htejun@gmail.com>, James.Bottomley@steeleye.com,
	axboe@suse.de, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050331090647.FEDC3964@htj.dyndns.org> <20050331090647.B562915C@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331090647.B562915C@htj.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		/* 
> -		 * This sets up the scatter-gather table (allocating if
> -		 * required).
> -		 */
> +		/* This sets up the scatter-gather table (allocating if
> +		 * required). */

the old comment style is the preferred in linux, please leave it as-is
(here and in other places)

