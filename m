Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUCWClQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUCWClP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:41:15 -0500
Received: from main.gmane.org ([80.91.224.249]:63707 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262128AbUCWClE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:41:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Synaptics touchpad + external mouse with Linux 2.6?
Date: Mon, 22 Mar 2004 18:41:08 -0800
Message-ID: <pan.2004.03.23.02.41.08.115427@triplehelix.org>
References: <m33c81lsnk.fsf@defiant.pm.waw.pl> <20040322061657.GA346@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-186-145.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004 07:16:57 +0100, Vojtech Pavlik wrote:
> I'm sorry to say it, but it's not possible. Well, it might be, but still
> the magic to recognize which device is sending the data would be rather
> crazy.

Forgive me if I'm being naive, but...

Why can't synaptics be transparent? Why can't it do all the stuff it
requires special userspace things for in kernel space?

I should think that mapping the scroll buttons to their normal PS/2
equivalents on a Synaptics touchpad is possible in kernel space.

A friend recently expressed his discontent with this condition when he
tried to plug in another mouse and use it while the Synaptics touchpad was
still present.

So, please enlighten me...

-- 
Joshua Kwan


