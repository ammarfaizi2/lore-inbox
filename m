Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933030AbWKLRbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030AbWKLRbL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 12:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933031AbWKLRbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 12:31:11 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:23825 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933030AbWKLRbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 12:31:09 -0500
Date: Sun, 12 Nov 2006 17:31:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Burman Yan <yan_952@hotmail.com>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATH] Replace kmalloc+memset with kzalloc 1/17
Message-ID: <20061112173103.GA14005@flint.arm.linux.org.uk>
Mail-Followup-To: Burman Yan <yan_952@hotmail.com>, trivial@kernel.org,
	linux-kernel@vger.kernel.org
References: <BAY20-F1803D00EDD5FC1FD65726ED8F50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY20-F1803D00EDD5FC1FD65726ED8F50@phx.gbl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 07:20:53PM +0200, Burman Yan wrote:
> This is the first part of the patches I made that do trivial change of 
> replacing
> kmalloc and memset with kzalloc

Please follow the guidelines in SubmittingPatches in the kernel source
when sending patches out.  You must not expect everyone here to read
each of the attachments in your messages in detail to work out whether
they need to do something with it or not.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
