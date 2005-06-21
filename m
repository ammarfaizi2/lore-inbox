Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVFUIIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVFUIIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVFUIHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:07:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:3050 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261966AbVFUGr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:47:27 -0400
Date: Mon, 20 Jun 2005 23:42:03 -0700
From: Greg KH <greg@kroah.com>
To: Josh Boyer <jdub@us.ibm.com>
Cc: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Denis Vlasenko <vda@ilport.com.ua>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050621064203.GB15239@kroah.com>
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com> <200506181806.49627.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua> <20050620164800.GA14798@suse.de> <42B6FBC7.5000900@pobox.com> <20050620173411.GB15212@suse.de> <1119296968.16063.1.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119296968.16063.1.camel@weaponx.rchland.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 02:49:28PM -0500, Josh Boyer wrote:
> 
> SLES 9 shipped with udev-021.
> 
> http://www.novell.com/products/linuxpackages/enterpriseserver/i386/udev.html
> 
> Is that effected by this?

First off, why would you be running a kernel.org kernel on an
"enterprise" distro?  I wouldn't recommend that at all, and you probably
loose your support contract if you try that out.

Secondly, no, it is not, see the previous post in this thread.

thanks,

greg k-h
