Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVBKRJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVBKRJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVBKRJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:09:51 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:13902 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262275AbVBKRIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:08:43 -0500
Date: Fri, 11 Feb 2005 09:08:29 -0800
From: Greg KH <gregkh@suse.de>
To: Olivier Galibert <galibert@pobox.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211170829.GD16074@suse.de>
References: <20050211004033.GA26624@suse.de> <20050211095237.GA53532@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211095237.GA53532@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 10:52:37AM +0100, Olivier Galibert wrote:
> On Thu, Feb 10, 2005 at 04:40:33PM -0800, Greg KH wrote:
> > 	- autoload programs for usb, scsi, and pci modules.  These
> > 	  programs determine what module needs to be loaded when the
> > 	  kernel emits a hotplug event for these types of devices.  This
> > 	  works just like the existing linux-hotplug scripts, with a few
> > 	  exceptions.
> 
> firmware?

On the todo list :)

thanks,

greg k-h
