Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUFJPXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUFJPXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUFJPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 11:23:13 -0400
Received: from mail.kroah.org ([65.200.24.183]:32707 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261610AbUFJPXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 11:23:12 -0400
Date: Wed, 9 Jun 2004 17:06:42 -0700
From: Greg KH <greg@kroah.com>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: Lars Knudsen <gandalf@revicon.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI configuration failure
Message-ID: <20040610000641.GA23763@kroah.com>
References: <40C733A0.8080700@revicon.com> <1086798127.21922.249.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086798127.21922.249.camel@sherbert>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 05:22:07PM +0100, Gianni Tedesco wrote:
> On Wed, 2004-06-09 at 17:58 +0200, Lars Knudsen wrote:
> > Any suggestions on how to fix this problem are highly appreciated.
> 
> Perhaps the 'resource' sysfs node could be made writable and allow
> remapping of BARs and resource lens in kernel?

The poster was not using the 2.6 kernel, but rather the 2.4 kernel,
which does not have sysfs :)

Anyway, what does 2.6 do with this hardware setup?

thanks,

greg k-h
