Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbTIBSot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTIBSot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:44:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:34251 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261176AbTIBSor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:44:47 -0400
Date: Tue, 2 Sep 2003 11:44:40 -0700
From: Greg KH <greg@kroah.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs to be obsloted by udev?
Message-ID: <20030902184440.GB18539@kroah.com>
References: <3F54A4AC.1020709@wmich.edu> <20030902182025.GA18397@kroah.com> <3F54A9F4.4020705@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F54A9F4.4020705@wmich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 10:32:20AM -0400, Ed Sweetman wrote:
> >>I dont see the real benefit in having two directories that basically
> >>give the same info.
> >
> >What "two directories"?  udev can handle /dev.  What other directory are
> >you talking about?
> 
> in your readme you  use the example of making the device root for udev 
> /udev ... I thought that was the official suggestion since udev couldn't 
> be loaded immediately at kernel boot.

That's my suggestion today if you want to have a machine that's usable
:)

greg k-h
