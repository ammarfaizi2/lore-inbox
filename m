Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTE0ROC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbTE0ROC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:14:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14098 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263957AbTE0ROB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:14:01 -0400
Date: Tue, 27 May 2003 10:26:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ricky Beam <jfbeam@bluetronic.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.70
In-Reply-To: <Pine.GSO.4.33.0305271245290.4448-100000@sweetums.bluetronic.net>
Message-ID: <Pine.LNX.4.44.0305271024060.6597-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 May 2003, Ricky Beam wrote:
> 
> Count up the number of drivers that haven't been updated to the current
> PCI, hotplug, and modules interfaces.

Tough. If people don't use them, they don't get supported. It's that easy.

The thing is, these things won't change before 2.6 (or at least a 
pre-2.6). When 2.6.0 comes out, and somebody notices that they haven't 
bothered to try the 2.5.x series, _then_ maybe some of those odd-ball 
drivers get fixed.

Or not. Some of them may be literally due for retirement, with users just 
running an old kernel on old hardware.

Btw, this is nothing new. It has _always_ been the case that a lot of 
people didn't use the latest stable kernel until it was released, and then 
they complained because the drivers they used weren't up to spec.

			Linus

