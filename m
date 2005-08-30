Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbVH3W4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbVH3W4G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVH3W4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:56:06 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:26839 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932245AbVH3W4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:56:05 -0400
Subject: Re: KLive: Linux Kernel Live Usage Monitor
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sven Ladegast <sven@linux4geeks.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0508310033400.1930@cassini.linux4geeks.de>
References: <20050830030959.GC8515@g5.random>
	 <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
	 <1125412611.8276.9.camel@localhost.localdomain>
	 <Pine.LNX.4.63.0508310033400.1930@cassini.linux4geeks.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Aug 2005 00:25:17 +0100
Message-Id: <1125444317.13646.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-08-31 at 00:43 +0200, Sven Ladegast wrote:
> collection has. What data does klive send? Is the data just a hash of
> different system variables or is it also possible to identify one single 
> computer (or person)? Data protection...laws etc. are things that must be 
> considered too maybe.

My thinking is something like this

"Register a box + optional PCI id list/CPU info"
Reply with a secured serial number 

Uptime data then can just be boot number, time up


> I think the problem is not the technical implementation. The bigger 
> problem is the data, where it comes from and the most interesting point 
> what to do with it at the end.

We don't need personally identifiable data (email, name, ip address etc)

What to do with it will be most interesting indeed.

