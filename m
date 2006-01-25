Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWAYSQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWAYSQT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWAYSQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:16:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:43524 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932079AbWAYSQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:16:18 -0500
Date: Wed, 25 Jan 2006 19:18:30 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANN: SiI opens more SATA chipsets
Message-ID: <20060125181830.GY4212@suse.de>
References: <20060125154920.GE14225@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125154920.GE14225@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2006, Jeff Garzik wrote:
> 
> Silicon Image has kindly granted permission to me, to post hardware
> documentation for the 3114 and 3124 chipsets:
> 
> http://gkernel.sourceforge.net/specs/sii/DS-0103A_3114.pdf.bz2
> http://gkernel.sourceforge.net/specs/sii/SiI-DS-0113_3124-1_full.pdf.bz2
> 
> I'll update the SATA web pages, to add to the list of open chipsets,
> when I return from my current biz trip.

Great news! That opens the door for sil ncq support as well.

-- 
Jens Axboe

