Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUAUA2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265904AbUAUA2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:28:10 -0500
Received: from mail.kroah.org ([65.200.24.183]:16552 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265902AbUAUA1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:27:51 -0500
Date: Tue, 20 Jan 2004 16:27:59 -0800
From: Greg KH <greg@kroah.com>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5
Message-ID: <20040121002759.GA5472@kroah.com>
References: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 05:56:42PM -0500, Thomas Molina wrote:
> /etc/hotplug/usb.agent: line 144: [: too many arguments

This is a bug in the latest release of the hotplug scripts.  See the
linux-hotplug-devel mailing list for a patch to solve this.

Sorry,

greg k-h
