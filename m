Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTKTBRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTKTBRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:17:47 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:2691 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261240AbTKTBRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:17:46 -0500
Date: Thu, 20 Nov 2003 01:12:09 +0000
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 006 release
Message-ID: <20031120011209.GA5719@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20031119162912.GA20835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119162912.GA20835@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 08:29:12AM -0800, Greg KH wrote:
 > I've released the 006 version of udev.  It can be found at:
 > 	kernel.org/pub/linux/utils/kernel/hotplug/udev-006.tar.gz
 > 
 > The udev BitKeeper tree has moved for now, due to kernel.bkbits.net
 > being off the air to:
 > 	bk://linuxusb.bkbits.net/udev
 > 
 > Note, to build using klibc, please read the klibc README in the klibc/
 > directory, and build using 'make -f Makefile.klibc'.
 > 
 > If anyone ever wants a snapshot of the current tree, due to not using
 > BitKeeper, or other reasons, is always available at any time by asking.

I just changed my sparse snapshotter to a generic bitkeeper repo snapshotting
script. Daily tarballs of udev as well as a daily unpacked tree can now also
be found at http://www.codemonkey.org.uk/projects/bitkeeper/udev/

		Dave

