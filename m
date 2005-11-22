Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVKVB33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVKVB33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 20:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVKVB33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 20:29:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:23520 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964826AbVKVB32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 20:29:28 -0500
Date: Mon, 21 Nov 2005 17:29:12 -0800
From: Greg KH <greg@kroah.com>
To: Jens-Michael Hoffmann <jensmh@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: white space fixes wanted?
Message-ID: <20051122012912.GA21199@kroah.com>
References: <200511220024.11046.jensmh@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511220024.11046.jensmh@gmx.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 12:24:08AM +0000, Jens-Michael Hoffmann wrote:
> When looking in drivers/ieee1394/pcilynx.c, I noticed that there are a lot of spaces instead of tabs.
> I prepared a patch to fix that.
> 
> file size of pcilynx.c before: 53775 bytes
> file size after:                         42870 bytes
> 
> patch size is 85356 bytes.
> 
> Should I send this patch to the mailing list?

How about to the ieee1394 developers?  They would be the best people to
be able to accept this change.

thanks,

greg k-h
