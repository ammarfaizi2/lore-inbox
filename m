Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292485AbSBUQGz>; Thu, 21 Feb 2002 11:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292487AbSBUQGp>; Thu, 21 Feb 2002 11:06:45 -0500
Received: from air-2.osdl.org ([65.201.151.6]:19980 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292485AbSBUQGa>;
	Thu, 21 Feb 2002 11:06:30 -0500
Date: Thu, 21 Feb 2002 08:00:45 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Giacomo Catenazzi <cate@debian.org>, <andersen@codepoet.org>,
        Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: linux kernel config converter
In-Reply-To: <3C7503B1.E7CA83AA@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33L2.0202210758300.1467-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Jeff Garzik wrote:

| For directories like kernel/* and mm/* and arch/*, I imagine that down
| the road we will want kernel.conf and mm.conf too, though right now they
| would probably remain as makefiles...

I agree.  I was just looking for linux/kernel/config.in a couple
of days ago.
Instead, I had to look in _many_ arch/<archxxx>/config.in files.
Bah.

-- 
~Randy

