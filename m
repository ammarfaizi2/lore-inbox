Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265941AbUFEDdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265941AbUFEDdC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 23:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUFEDdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 23:33:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:16859 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264514AbUFEDc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 23:32:57 -0400
Date: Fri, 4 Jun 2004 20:29:02 -0700
From: Greg KH <greg@kroah.com>
To: davidm@hpl.hp.com
Cc: Michael_E_Brown@dell.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: EFI-support for SMBIOS driver
Message-ID: <20040605032902.GA7069@kroah.com>
References: <16577.6469.833064.763671@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16577.6469.833064.763671@napali.hpl.hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 05:52:21PM -0700, David Mosberger wrote:
> Michael,
> 
> The patch below adds EFI support to the SMBIOS driver.

The smbios driver is gone in 2.6.7-rc.  You don't need a driver for
this, as you can do everything from userspace.

thanks,

greg k-h
