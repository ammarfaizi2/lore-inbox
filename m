Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVKGRsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVKGRsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVKGRsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:48:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:24549 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964982AbVKGRsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:48:15 -0500
Date: Mon, 7 Nov 2005 09:47:03 -0800
From: Greg KH <greg@kroah.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051107174703.GE17004@kroah.com>
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com> <43691E7E.5090902@free.fr> <436E4EFA.2000307@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436E4EFA.2000307@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2005 at 07:44:10PM +0100, matthieu castet wrote:
> - For the license stuff, all the dual bsd/gpl drivers I saw in the 
> kernel tree have the complete bsd header.

That's fine.

> - For the header file I prefer a separate header file, but if Linux 
> policy is to merge header and source file, that's fine.

It's ok, as long as it is local, and it is what you want to do.  I don't
have a strong feeling toward it.

thanks,

greg k-h
