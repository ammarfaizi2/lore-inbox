Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUBYMHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 07:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUBYMHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 07:07:39 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:61145 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261280AbUBYMHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 07:07:33 -0500
Date: Wed, 25 Feb 2004 12:06:25 +0000
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb-uhci rmmod fun
Message-ID: <20040225120625.GD11203@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040225005241.GB11203@redhat.com> <20040225020001.GA4265@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225020001.GA4265@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 06:00:01PM -0800, Greg KH wrote:

 > > Unloading the usb controller loads the floppy controller!?
 > Heh, I have no idea why that happens.  I can't duplicate that here.
 > What version of your hotplug scripts are you using?

the ones from Fedora Core 2 test 1 (2004_01_05-1)

 > What kernel version?

2.6.3-bk5

 > Do you have kmod enabled?

yep.

		Dave

