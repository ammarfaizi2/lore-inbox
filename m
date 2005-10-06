Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVJFScO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVJFScO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 14:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbVJFScN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 14:32:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:34506 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751283AbVJFScN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 14:32:13 -0400
Date: Thu, 6 Oct 2005 11:31:41 -0700
From: Greg KH <greg@kroah.com>
To: Freaky <freaky@bananateam.nl>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: MTP - Media Transfer Protocol support
Message-ID: <20051006183141.GA14663@kroah.com>
References: <4344DB73.9020604@bananateam.nl> <200510061128.48506.oliver@neukum.org> <1069.192.168.0.39.1128596539.squirrel@webmail.bananateam.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069.192.168.0.39.1128596539.squirrel@webmail.bananateam.nl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 01:02:19PM +0200, Freaky wrote:
> Can't check now, but what I mean is that syslog will only give one line,
> that an USB device is inserted. Nothing more. I can find the device in
> /sys/usb... so the system sees it, it just doesn't know what to do with
> it.

There is no such directory as "/sys/usb", sorry.

greg k-h
