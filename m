Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWGMNic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWGMNic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 09:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWGMNib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 09:38:31 -0400
Received: from beer.tclug.org ([71.36.145.29]:30929 "EHLO beer.tclug.org")
	by vger.kernel.org with ESMTP id S1750881AbWGMNia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 09:38:30 -0400
Date: Thu, 13 Jul 2006 08:38:28 -0500 (CDT)
From: Jima <jima@beer.tclug.org>
To: Mikael Pettersson <mikpe@it.uu.se>
cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
In-Reply-To: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.64.0607130836140.13948@beer.tclug.org>
References: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jima@beer.tclug.org
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SA-Exim-Version: 4.1+cvs (built Mon, 23 Aug 2004 08:44:05 -0700)
X-SA-Exim-Scanned: No (on beer.tclug.org); Unknown failure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006, Mikael Pettersson wrote:
> So ttyS0 became ttyS1, and the serial port at 0x1fff1400040
> disappeared. OTOH, my Ultra5 only has a single serial port
> connector so perhaps the old kernel was wrong in reporting
> two serial ports.

  I don't know about you, but my Ultra 5 has two: the DB25 female connector 
on the board ("A"), and the DB9 male connector on a ribbon cable ("B"). 
This is going off memory, but I'm fairly confident of this.

      Jima
