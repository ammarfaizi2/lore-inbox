Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVFUJck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVFUJck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 05:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVFUIJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:09:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:8426 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262051AbVFUGrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:47:37 -0400
Date: Mon, 20 Jun 2005 23:47:28 -0700
From: Greg KH <greg@kroah.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Greg KH <gregkh@suse.de>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Message-ID: <20050621064728.GD15239@kroah.com>
References: <200506181332.25287.nick@linicks.net> <200506202000.08114.nick@linicks.net> <20050620192118.GA13586@suse.de> <200506202032.30771.nick@linicks.net> <Pine.LNX.4.62.0506201242100.13723@qynat.qvtvafvgr.pbz> <20050621062843.GA15062@kroah.com> <Pine.LNX.4.62.0506202330020.14659@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0506202330020.14659@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 11:31:15PM -0700, David Lang wrote:
> I'll check tomorrow, I was useing what was on the FC3 iso images, it would 
> eventually boot, but it would hang on udev with a 2.6.11.x or 2.6.12-pre6 
> kernel for 2-3 min before continueing through the boot.

Ok, if you saw this on 2.6.11.x, then it's not the same udev issue that
was caused in the 2.6.12-preX tree.  That must be something different.

thanks,

greg k-h
