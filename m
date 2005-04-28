Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVD1Wht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVD1Wht (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 18:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVD1Wht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 18:37:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:43216 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262306AbVD1WhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 18:37:16 -0400
Date: Thu, 28 Apr 2005 15:36:22 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       sensors@stimpy.netroedge.com
Subject: Re: kernel maintainer's HOWTO for quilt and -mm
Message-ID: <20050428223622.GC22785@kroah.com>
References: <20050428223414.GA22785@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428223414.GA22785@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 03:34:14PM -0700, Greg KH wrote:
> Examples of the output of this script can be seen at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/

Andrew, I'm now putting my broken out patches in this directory so you
can apply them to the -mm tree.  You can take them in the 4 big chunks
(they all apply one after each other), or you can take the individual
patches if you want too (they also apply, one after each other.)  It's
up to you what is easier for you to handle.

Does this work out for you?

thanks,

greg k-h
