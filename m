Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUHWU2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUHWU2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbUHWU0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:26:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:16869 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266663AbUHWUAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:00:17 -0400
Date: Mon, 23 Aug 2004 12:47:17 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
Message-ID: <20040823194717.GA2361@kroah.com>
References: <10932860811635@kroah.com> <10932860812879@kroah.com> <20040823193013.GA9831@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823193013.GA9831@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 08:30:14PM +0100, Dave Jones wrote:
> On Mon, Aug 23, 2004 at 11:34:41AM -0700, Greg KH wrote:
>  > ChangeSet 1.1790.2.2, 2004/08/02 15:24:01-07:00, greg@kroah.com
>  > 
>  > PCI: update pci.ids from sf.net site.
>  > 
>  > Patch taken from http://www.codemonkey.org.uk/projects/pci/pci.ids-2004-08-02.diff
>  > and tweaked by hand to build with no warnings.
> 
> Did you push those tweaks back to the pciids.sf.net site ?

I did not have the chance to do so yet, but will soon, thanks for
reminding me.

greg k-h
