Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVKUAuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVKUAuH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbVKUAuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:50:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:58821 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932148AbVKUAuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:50:04 -0500
Date: Sun, 20 Nov 2005 16:24:35 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: rolandd@cisco.com, mshefty@ichips.intel.com, halr@voltaire.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       stable@kernel.org, markus.lidel@shadowconnect.com,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Subject: Re: [stable] [2.6 patch] drivers/infiniband/core/mad.c: fix a NULL pointer dereference
Message-ID: <20051121002435.GB9749@kroah.com>
References: <20051120230050.GB16060@stusta.de> <20051120230826.GD16060@stusta.de> <20051120231411.GF16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120230050.GB16060@stusta.de> <20051120230826.GD16060@stusta.de> <20051120231411.GF16060@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please send these again to the stable@ address when they have been
accepted into upstream.

thanks,

greg k-h
