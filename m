Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVEaPrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVEaPrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVEaPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:47:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1430 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261880AbVEaPrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:47:31 -0400
Date: Tue, 31 May 2005 17:48:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ #3
Message-ID: <20050531154825.GB13816@suse.de>
References: <20050531124659.GB1530@suse.de> <429C86AD.4050605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C86AD.4050605@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31 2005, Jeff Garzik wrote:
> BTW, does the AHCI PCI MSI patch work for you?
> 
> I still haven't gotten any acks back from anybody yet, and PCI MSI 
> support should make the driver even more efficient.

I will give it a shot, cannot before the morning though.

-- 
Jens Axboe

