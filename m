Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbUKSRVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUKSRVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUKSRRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:17:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:18362 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261491AbUKSRQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:16:00 -0500
Date: Fri, 19 Nov 2004 09:12:04 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Leibold <thomas@plx.com>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] i2c-nforce2.c add support for nForce3 Pro 150 MCP
Message-ID: <20041119171204.GA19845@kroah.com>
References: <20041116222506.7c64e122.khali@linux-fr.org> <33599.192.168.0.19.1100773423.squirrel@192.168.0.12>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33599.192.168.0.19.1100773423.squirrel@192.168.0.12>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:23:43AM -0800, Thomas Leibold wrote:
> Hi Greg,
> 
> This is the all new and improved version of the patch:
> - following the advise from Jean Delvare I removed the redundant definition
> of the PCI IDs from the driver and just add them to the pci_ids.h file.
> - the patch is now created against linux 2.6.10-RC2.
> 
> Signed-off-by: Thomas Leibold <thomas@plx.com>

Applied, thanks.

greg k-h
