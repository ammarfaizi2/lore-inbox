Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUAUBfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 20:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265744AbUAUBfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 20:35:06 -0500
Received: from [24.35.117.106] ([24.35.117.106]:57734 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261733AbUAUBeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 20:34:10 -0500
Date: Tue, 20 Jan 2004 20:33:57 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm5
In-Reply-To: <20040121002759.GA5472@kroah.com>
Message-ID: <Pine.LNX.4.58.0401202033290.9398@localhost.localdomain>
References: <Pine.LNX.4.58.0401201724190.9398@localhost.localdomain>
 <20040121002759.GA5472@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jan 2004, Greg KH wrote:

> On Tue, Jan 20, 2004 at 05:56:42PM -0500, Thomas Molina wrote:
> > /etc/hotplug/usb.agent: line 144: [: too many arguments
> 
> This is a bug in the latest release of the hotplug scripts.  See the
> linux-hotplug-devel mailing list for a patch to solve this.

Thanks for the pointer.  That fixed this problem.
