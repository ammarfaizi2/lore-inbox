Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVH3IBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVH3IBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVH3IBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:01:36 -0400
Received: from newton.linux4geeks.de ([193.30.1.1]:52101 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S1751207AbVH3IBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:01:36 -0400
Date: Tue, 30 Aug 2005 10:01:21 +0200 (CEST)
From: Sven Ladegast <sven@linux4geeks.de>
To: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
In-Reply-To: <20050830030959.GC8515@g5.random>
Message-ID: <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de>
References: <20050830030959.GC8515@g5.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2005, Andrea Arcangeli wrote:

> During the Kernel Summit somebody raised the point that it's not clear
> how much testing each rc/pre/git kernel gets before the final release.

Generally this is a good idea to track the usage/testing time of different 
versions.

> In theory we could get rid of the client entirely and make it a kernel
> config option, but I've no idea if this project is useful, so I don't
> want to spend too much time on it at this point.

The idea isn't bad but lots of people could think that this is some kind 
of home-phoning or spy software. I guess lots of people would turn this 
feature off...and of course you can't enable it by default. But combined 
with an automatic oops/panic/bug-report this would be _very_ useful I think.

Let's see what others say about it.

Sven

