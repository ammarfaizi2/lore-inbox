Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265097AbUEUXCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265097AbUEUXCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUEUWmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:42:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:6848 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266092AbUEUWdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:07 -0400
Date: Wed, 19 May 2004 13:49:59 -0700
From: Greg KH <greg@kroah.com>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Olaf Hering <olh@suse.de>,
       akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [BK PATCH] USB changes for 2.6.6
Message-ID: <20040519204959.GB2020@kroah.com>
References: <20040514224516.GA16814@kroah.com> <20040515113251.GA27011@suse.de> <Pine.LNX.4.58.0405151034500.10718@ppc970.osdl.org> <20040519203321.GA20979@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519203321.GA20979@linux.nu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 10:33:21PM +0200, Erik Rigtorp wrote:
> On Sat, May 15, 2004 at 10:37:10AM -0700, Linus Torvalds wrote:
> > Replace all "led" with "cytherm". The code was crap, and would never have
> > compiled with debugging on anyway. 
> 
> I fixed my crappy code. :)

Linus already did it for you, the tree is fixed :)

thanks,

greg k-h
