Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWHGEsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWHGEsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 00:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWHGEsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 00:48:12 -0400
Received: from mx1.suse.de ([195.135.220.2]:51360 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751025AbWHGEsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 00:48:11 -0400
Date: Sun, 6 Aug 2006 21:47:37 -0700
From: Greg KH <greg@kroah.com>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace last instances of pci_module_init with pci_register_driver
Message-ID: <20060807044737.GA20013@kroah.com>
References: <20060807043154.7901.74081.stgit@dv.roinet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807043154.7901.74081.stgit@dv.roinet.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 12:31:54AM -0400, Pavel Roskin wrote:
> From: Pavel Roskin <proski@gnu.org>
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> ---
> 
>  drivers/net/3c59x.c                           |    2 +-
>  drivers/net/8139cp.c                          |    2 +-

You are going to have to send this through the network and scsi driver
maintainers, it's not something that I can apply, sorry.

good luck,

greg k-h
