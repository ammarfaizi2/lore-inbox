Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVEIUID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVEIUID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 16:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVEIUID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 16:08:03 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:11659 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261500AbVEIUH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 16:07:57 -0400
Date: Mon, 9 May 2005 16:07:21 -0400
To: Rudolf Usselmann <rudi@asics.ws>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: kernel (64bit) 4GB memory support
Message-ID: <20050509200721.GE2297@csclub.uwaterloo.ca>
References: <Pine.LNX.4.61.0412120934160.14734@montezuma.fsmlabs.com> <1103027130.3650.73.camel@cpu0> <20041216074905.GA2417@c9x.org> <1103213359.31392.71.camel@cpu0> <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com> <1103646195.3652.196.camel@cpu0> <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com> <1103647158.3659.199.camel@cpu0> <Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com> <1115654185.3296.658.camel@cpu10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115654185.3296.658.camel@cpu10>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 10:56:25PM +0700, Rudolf Usselmann wrote:
> Just curious, did anybody ever look in to this at all ? I keep
> on downloading new kernels and trying 4GB of memory - still no
> luck.
> 
> I did file a bug report but didn't get any notifications at all.
> I don't subscribe to the linux-kernel list so not sure if anything
> ever came up or not.
> 
> Is there a way to get this fixed ?

How much ram do you see with 4GB installed running a 64bit kernel?

What does /proc/meminfo show?

How about the memory map dmesg shows at the start of boot?

Len Sorensen
