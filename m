Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbULHTqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbULHTqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbULHTqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:46:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47323 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261332AbULHTqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:46:31 -0500
Date: Wed, 8 Dec 2004 11:46:18 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 048 release
Message-ID: <20041208194618.GA28810@kroah.com>
References: <20041208185856.GA26734@kroah.com> <20041208192810.GA28374@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208192810.GA28374@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 11:28:10AM -0800, Greg KH wrote:
> On Wed, Dec 08, 2004 at 10:58:56AM -0800, Greg KH wrote:
> > I've released the 047 version of udev.  It can be found at:
> >   	kernel.org/pub/linux/utils/kernel/hotplug/udev-046.tar.gz
> 
> Ick, the programs in the extras/ directory don't seem to build anymore.
> I'll fix that up and do a new release in a few hours.  Sorry about
> that...

Ok, version 048 has been released to fix the build errors for the
extras/ directory.  It's available at
	kernel.org/pub/linux/utils/kernel/hotplug/udev-048.tar.gz

thanks,

greg k-h
