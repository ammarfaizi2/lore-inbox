Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUKQRvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUKQRvp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbUKQRuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:50:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:20386 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262356AbUKQRow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:44:52 -0500
Date: Wed, 17 Nov 2004 09:44:33 -0800
From: Greg KH <greg@kroah.com>
To: James.Smart@Emulex.Com
Cc: linux-kernel@vger.kernel.org, linux-os@chaos.analogic.com,
       jes@wildopensource.com
Subject: Re: Potential issue with some implementations of pci_resource_start()
Message-ID: <20041117174433.GB28285@kroah.com>
References: <0B1E13B586976742A7599D71A6AC733C02F276@xbl3.ma.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0B1E13B586976742A7599D71A6AC733C02F276@xbl3.ma.emulex.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 09:18:27AM -0500, James.Smart@Emulex.Com wrote:
> 
> Can someone please update Documentation/pci.txt so that it has correct
> definitions for pci_resource_start() and pci_resource_end()...

Patches gladly accepted for this.  And as you now know exactly what is
missing, you might be the best person to write such a patch :)

thanks,

greg k-h
