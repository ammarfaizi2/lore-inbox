Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264827AbUDWRUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbUDWRUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbUDWRUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:20:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:60395 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264827AbUDWRUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:20:15 -0400
Date: Fri, 23 Apr 2004 10:19:53 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040423171953.GB13835@kroah.com>
References: <200404230142.46792.dtor_core@ameritech.net> <1082723147.1843.14.camel@merlin> <200404230802.42293.dtor_core@ameritech.net> <20040423153111.GB12126@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423153111.GB12126@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 08:31:11AM -0700, Greg KH wrote:
> 
> No, we need to oops, as that's a real bug.  Can you post the whole oops
> that was generated with this usb problem?  I can't seem to duplicate
> this here.

Nevermind I dug up a device here that causes this problem.  I'll track
it down...

thanks,

greg k-h
