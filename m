Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267017AbUBFBJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 20:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267101AbUBFBJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 20:09:22 -0500
Received: from mail.kroah.org ([65.200.24.183]:31389 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267017AbUBFBJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 20:09:21 -0500
Date: Thu, 5 Feb 2004 17:09:12 -0800
From: Greg KH <greg@kroah.com>
To: mikem@beardog.cca.cpqcorp.net
Cc: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6 [1 of 11]
Message-ID: <20040206010912.GE18681@kroah.com>
References: <Pine.LNX.4.58.0402041737080.18320@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402041737080.18320@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 06:04:46PM -0600, mikem@beardog.cca.cpqcorp.net wrote:
> +
> +static int find_PCI_BAR_index(struct pci_dev *pdev,
> +				unsigned long pci_bar_addr)

What are you trying to do here that the PCI core doesn't do already?

thanks,

greg k-h
