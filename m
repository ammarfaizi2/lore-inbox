Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVH3WoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVH3WoU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVH3WoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:44:19 -0400
Received: from newton.linux4geeks.de ([193.30.1.1]:61831 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S932279AbVH3WoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:44:18 -0400
Date: Wed, 31 Aug 2005 00:43:59 +0200 (CEST)
From: Sven Ladegast <sven@linux4geeks.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
In-Reply-To: <1125412611.8276.9.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0508310033400.1930@cassini.linux4geeks.de>
References: <20050830030959.GC8515@g5.random> 
 <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
 <1125412611.8276.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Alan Cox wrote:

> but it would have to be opt in. That might lower coverage but should
> increase quality, especially id the id in the cookie can be put into
> bugzilla reports, and the hardware reporting is done so it can be
> machine processed (ie so you can ask stuff like 'reliability with Nvidia
> IDE')

Maybe I used the wrong words... But you are right: It has to be opt-in! A 
change in the kernel sources which automagically sends data, regardless 
what kind of data, to somewhere in the net must not be enabled by default.

But until klive is implemented one day it is interesting thinking about 
what possibilities (and maybe even possible misuse) such a data 
collection has. What data does klive send? Is the data just a hash of
different system variables or is it also possible to identify one single 
computer (or person)? Data protection...laws etc. are things that must be 
considered too maybe.

I think the problem is not the technical implementation. The bigger 
problem is the data, where it comes from and the most interesting point 
what to do with it at the end.

Sven
