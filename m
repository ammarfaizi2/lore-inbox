Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUF0FE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUF0FE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 01:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUF0FE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 01:04:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:7050 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266244AbUF0FEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 01:04:52 -0400
Date: Sat, 26 Jun 2004 22:02:01 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pete Zaitcev <zaitcev@redhat.com>, arjanv@redhat.com, jgarzik@redhat.com,
       tburke@redhat.com, linux-kernel@vger.kernel.org,
       mdharm-usb@one-eyed-alien.net, david-b@pacbell.net, oliver@neukum.org
Subject: Re: drivers/block/ub.c
Message-ID: <20040627050201.GA24788@kroah.com>
References: <20040626130645.55be13ce@lembas.zaitcev.lan> <Pine.LNX.4.44L0.0406262356110.30028-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0406262356110.30028-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 12:05:22AM -0400, Alan Stern wrote:
> It look like you are targeting ub for Linux 2.4.  Do you intend to use it 
> with 2.6?  An important difference between the two kernel versions is that 
> in 2.6 we do not try to make devices persistent across disconnections by 
> recognizing some type of unique ID.

The patch was against 2.6.7.  Why do you think this is for 2.4?

greg k-h
