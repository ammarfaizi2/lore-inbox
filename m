Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131777AbRCOTZn>; Thu, 15 Mar 2001 14:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131732AbRCOTZ1>; Thu, 15 Mar 2001 14:25:27 -0500
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:7947 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S131809AbRCOTYN>; Thu, 15 Mar 2001 14:24:13 -0500
Date: Thu, 15 Mar 2001 14:22:44 -0500 (EST)
From: William T Wilson <fluffy@snurgle.org>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <B65FF72654C9F944A02CF9CC22034CE22E1B39@mail0.myrio.com>
Message-ID: <Pine.LNX.4.21.0103151421380.22425-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Torrey Hoffman wrote:

> IIRC, when this discussion of swap size first came up, the general
> conclusion was NOT that you should have swap = 2 * RAM, but that you
> should have swap(2.4.x) = 2 * swap(2.2.x), that is, twice as much swap
> as you did under 2.2.x.

it seems to me that in 2.2.x it looks like this:

total usage == swap + RAM
under 2.4.x it looks like:
total usage == swap

> So if you never swapped at all under 2.2.x, you should not need any 
> swap space in 2.4.x either. 

Right.

