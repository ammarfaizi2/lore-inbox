Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262983AbVHESjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262983AbVHESjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 14:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVHEShC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 14:37:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:52161 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263011AbVHESgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 14:36:50 -0400
Date: Fri, 5 Aug 2005 11:36:27 -0700
From: Greg KH <greg@kroah.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com
Subject: Re: [PATCH] new contact info
Message-ID: <20050805183626.GB32405@kroah.com>
References: <1123260594.8917.13.camel@whizzy> <200508051109.56230.bjorn.helgaas@hp.com> <1123265168.8917.22.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123265168.8917.22.camel@whizzy>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 11:06:08AM -0700, Kristen Accardi wrote:
> diff -uprN -X linux-2.6.13-rc5/Documentation/dontdiff linux-2.6.13-rc5/MAINTAINERS linux-2.6.13-rc5-new/MAINTAINERS
> --- linux-2.6.13-rc5/MAINTAINERS	2005-08-01 21:45:48.000000000 -0700
> +++ linux-2.6.13-rc5-new/MAINTAINERS	2005-08-05 11:03:36.000000000 -0700
> @@ -1825,6 +1825,11 @@ P:	Greg Kroah-Hartman
>  M:	greg@kroah.com
>  S:	Maintained
>  
> +PCIE HOTPLUG DRIVER
> +P:	Kristen Carlson Accardi
> +M:	kristen.c.accardi@intel.com
> +S:	Maintained

Care to try it again, and add the pcihpd mailing list address too?  That
is the place to talk about pci hotplug drivers, right?

thanks,

greg k-h
