Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbUKMAOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbUKMAOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUKMANE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:13:04 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:144 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262749AbUKMAMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 19:12:20 -0500
Date: Fri, 12 Nov 2004 16:11:58 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-ID: <20041113001158.GB17877@kroah.com>
References: <20041111012333.1b529478.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 01:23:33AM -0800, Andrew Morton wrote:
> 
> - Let me be the first to report this:
> 
> 	*** Warning: "hotplug_path" [drivers/acpi/container.ko] undefined!

The acpi developers know about this and they said they would fix it in
their code tree before pushing to Linus.

thanks,

greg k-h
