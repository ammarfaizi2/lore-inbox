Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUBJWg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUBJWg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:36:57 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:27801 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262048AbUBJWg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:36:56 -0500
Date: Tue, 10 Feb 2004 14:37:11 -0800
From: Greg KH <gregkh@us.ibm.com>
To: johnrose@austin.ibm.com
Cc: linux-kernel@vger.kernel.org, johnrose@us.ibm.com, wortman@us.ibm.com,
       lxie@us.ibm.com, scheel@us.ibm.com,
       pcihpd-discuss@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] PPC64 PCI Hotplug/DLPAR Drivers for RPA
Message-ID: <20040210223711.GC3990@us.ibm.com>
References: <200402102219.i1AMJgXN022285@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402102219.i1AMJgXN022285@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.3-rc1 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 04:19:42PM -0600, johnrose@austin.ibm.com wrote:
> Please condider the following patch for inclusion.  This patch contains
> implementations of the PCI Hotplug and I/O Slot DLPAR Drivers for PPC64 RISC
> Platform Architecture.  The patch is made against kernel version 2.6.3-rc2.  

Please split this into two pieces, and make the other minor changes I've
already sent to you, and resend it.  It should fit inline with the
split-up to the mailing lists just fine.

thanks,

greg k-h
