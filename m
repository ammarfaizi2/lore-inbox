Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVANTjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVANTjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVANTjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:39:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:19610 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262047AbVANTiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:38:55 -0500
Date: Fri, 14 Jan 2005 11:29:00 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: lkml Development <linux-kernel@vger.kernel.org>
Subject: Re: unregisters a device that doesnt exist
Message-ID: <20050114192900.GA8374@kroah.com>
References: <804898BA-6660-11D9-A893-000393DBC2E8@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804898BA-6660-11D9-A893-000393DBC2E8@freescale.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 01:14:23PM -0600, Kumar Gala wrote:
> Is it possible to unregister a device (more specifically a 
> platform_device) if its hasnt already be registered?

I think it will fail in wonderful and mysterious ways, have you tried
it?

> If not, is there a way to determine if the device has been registered.

Hm, you were the one that registered it, can't you remember if you did
it or not?  :)

thanks,

greg k-h
