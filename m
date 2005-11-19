Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbVKSBeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbVKSBeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 20:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbVKSBeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 20:34:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:6077 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030271AbVKSBeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 20:34:04 -0500
Date: Fri, 18 Nov 2005 17:14:15 -0800
From: Greg KH <greg@kroah.com>
To: "Jordan, William P" <William.Jordan@unisys.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: bug in drivers/pci/hotplug/ibmphp_pci.c
Message-ID: <20051119011415.GA28175@kroah.com>
References: <5E735516D527134997ABD465886BBDA61ABFA7@USTR-EXCH5.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E735516D527134997ABD465886BBDA61ABFA7@USTR-EXCH5.na.uis.unisys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 09:58:50AM -0500, Jordan, William P wrote:
> 
> I noticed what appears to be a cut/paste error in
> drivers/pci/hotplug/ibmphp_pci.c:

Yes it does look like that.  Does changing this solve a problem that you
have been seeing?

If so, care to resend this, in the format specified in
Documentation/SubmittingPatches so that I can get the change into the
kernel tree?

thanks,

greg k-h
