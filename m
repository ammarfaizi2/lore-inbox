Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266846AbSLWQfS>; Mon, 23 Dec 2002 11:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266859AbSLWQfS>; Mon, 23 Dec 2002 11:35:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:61589 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266846AbSLWQfR>;
	Mon, 23 Dec 2002 11:35:17 -0500
Date: Mon, 23 Dec 2002 08:41:49 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Gianni Tedesco <gianni@ecsc.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: Re: NMI: IOCK error (debug interrupt?) - nope
In-Reply-To: <20021223152812.GA7773@suse.de>
Message-ID: <Pine.LNX.4.33L2.0212230840400.20684-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2002, Dave Jones wrote:

| On Mon, Dec 23, 2002 at 03:12:22PM +0000, Gianni Tedesco wrote:
|  > > When we looked in the logs there was this. Presumably the hardware is
|  > > broken. But I wonder if anyone can confirm this? Thanks!
|  > >
|  > > NMI: IOCK error (debug interrupt?)
|  >
|  > Turns out to be a 2bit ECC error. The machine is a dell power-edge 350.
|
| A while ago I mentioned it would be nice to get the ECC drivers
| cleaned up and included. Any yays or nays to getting this stuff
| done sometime ?

Yes!

| Yes it's a feature, but it's also just extra drivers.
| Decisions decisions...

Put that way, any driver is a feature, but that's not the point AFAIK.
So go with more drivers...

-- 
~Randy

