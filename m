Return-Path: <linux-kernel-owner+w=401wt.eu-S1753457AbWLOVgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbWLOVgr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753452AbWLOVgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:36:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38761 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbWLOVgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:36:46 -0500
Date: Fri, 15 Dec 2006 16:36:39 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18.5 usb/sysfs bug.
Message-ID: <20061215213639.GA15792@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061215175027.GA17987@redhat.com> <20061215175344.GA15871@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215175344.GA15871@kroah.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 09:53:44AM -0800, Greg Kroah-Hartman wrote:
 > On Fri, Dec 15, 2006 at 12:50:27PM -0500, Dave Jones wrote:
 > > Happens during every boot, though bootup continues afterwards.
 > 
 > Can you enable CONFIG_USB_DEBUG and send the log info that happens right
 > before this oops?

It doesn't seem much more enlightening to me, but full dmesg below.

 > > I'll give .20rc1 a shot real soon.
 > 2.6.19 would be interesting to try too.  I'll be worried if it's not
 > fixed there.

Ok, I'll do that first.

		Dave
-- 
http://www.codemonkey.org.uk
