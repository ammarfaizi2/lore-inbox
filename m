Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWELU4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWELU4M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWELU4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 16:56:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:35005 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932238AbWELU4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 16:56:11 -0400
Date: Fri, 12 May 2006 13:54:15 -0700
From: Greg KH <greg@kroah.com>
To: Captain Wiggum <captwiggum@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.6.16.14 boot errors: udevd-event: udev_make_node and find_free_number
Message-ID: <20060512205415.GB26501@kroah.com>
References: <3d78499d0605121129m3fe0951fy68e55ec1dce13397@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d78499d0605121129m3fe0951fy68e55ec1dce13397@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 01:29:52PM -0500, Captain Wiggum wrote:
> My 2.6.15.4 booted without any errors or warnings. Now with 2.6.16.14 I
> get the below errors. I have also installed 2.6.16.14 on another
> computer, and it works great there. I stepped through every kernel
> config option and everything is in place.
> 
> Any ideas? All suggestions appreciated.

Try filing a bug in your distro's bugzilla, as this should not be a
kernel issue, but a udev issue.  Or really, an intregration issue.

thanks,

greg k-h
