Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263406AbSJGVXe>; Mon, 7 Oct 2002 17:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263407AbSJGVXe>; Mon, 7 Oct 2002 17:23:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61606 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263406AbSJGVXc>;
	Mon, 7 Oct 2002 17:23:32 -0400
Date: Mon, 7 Oct 2002 14:31:24 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Burton Windle <bwindle@fint.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.41] Oops on reboot in device_remove_file
In-Reply-To: <Pine.LNX.4.43.0210071653490.6732-100000@morpheus>
Message-ID: <Pine.LNX.4.44.0210071428260.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Burton Windle wrote:

> 2.5.41, after "Rebooting..." is printed, I get this oops:

There is a series of patches that I posted a few hours ago which should 
solve this problem. I apologize; I forgot to state that they should fix 
this Oops. It was reported a couple of days ago, as well..

If you're using BK, you can pull from

bk://ldm.bkbits.net/linux-2.5-ide

Or search the archives starting here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103401951632484&w=2


If you're feeling adventurous, please apply them and let me know if they 
fix the problem for you.

Thanks,

	-pat

