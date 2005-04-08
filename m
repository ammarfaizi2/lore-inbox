Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVDHSub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVDHSub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVDHSua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:50:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:23482 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262921AbVDHSuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:50:25 -0400
Date: Fri, 8 Apr 2005 11:33:14 -0700
From: Greg KH <greg@kroah.com>
To: Christopher Li <chrisl@vmware.com>
Cc: linux kernel mail list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] bug fix in usbdevfs
Message-ID: <20050408183314.GD18987@kroah.com>
References: <20050331005123.GA541@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331005123.GA541@64m.dyndns.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 07:51:23PM -0500, Christopher Li wrote:
> Hi,
> 
> I am sorry that the last patch about 32 bit compat ioctl on
> 64 bit kernel actually breaks the usbdevfs. That is on the current
> BK tree. I am retarded. 
> 
> Here is the patch to fix it. Tested with USB hard disk and webcam
> in both 32bit compatible mode and native 64bit mode.
> 
> Again, sorry about that.

Applied, thanks.

greg k-h
