Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUHJXtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUHJXtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267832AbUHJXtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:49:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:22928 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267829AbUHJXto (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:49:44 -0400
Date: Tue, 10 Aug 2004 16:41:15 -0700
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH 2.6] Remove spaces from PCI I2C pci_driver.name fields
Message-ID: <20040810234115.GB22039@kroah.com>
References: <20040810003824.GA8643@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810003824.GA8643@plexity.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2004 at 05:38:24PM -0700, Deepak Saxena wrote:
> 
> Greg,
> 
> Same thing as IDE...spaces in PCI driver names show up in sysfs file 
> names.  I've also cleaned up all the .name fields to be in the format 
> (${NAME}_i2c|${NAME}_smbus) so they are consistent.
> 
> Please apply,

Applied, thanks.

greg k-h

