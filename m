Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVBELE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVBELE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbVBELCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:02:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3484 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266592AbVBEKno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 05:43:44 -0500
Date: Sat, 5 Feb 2005 10:43:41 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Tejun Heo <tj@home-tj.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 09/09] ide: remove REQ_DRIVE_CMD handling
Message-ID: <20050205104341.GB1184@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@home-tj.org>, bzolnier@gmail.com,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <42049F20.7020706@home-tj.org> <20050205102843.C930C132706@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205102843.C930C132706@htj.dyndns.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -	__REQ_DRIVE_CMD,
> +	__REQ_DRIVE_CMD,	/* obsolete, unused anymore - tj */

dito

