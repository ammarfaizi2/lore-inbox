Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVDHAVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVDHAVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVDHAVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:21:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:16516 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262632AbVDHAUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:20:55 -0400
Date: Thu, 7 Apr 2005 17:20:25 -0700
From: Greg KH <gregkh@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fix u32 vs. pm_message_t in PCI, PCIE
Message-ID: <20050408002025.GF7010@kroah.com>
References: <20050402212319.GA2128@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402212319.GA2128@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 11:23:19PM +0200, Pavel Machek wrote:
> Hi!
> 
> This fixes drivers/pci (mostly pcie stuff). [These patches are
> independend and change no object code; therefore not numbered].
> 
> Please apply,

Applied, thanks.

greg k-h
