Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbSLIOAY>; Mon, 9 Dec 2002 09:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbSLIOAY>; Mon, 9 Dec 2002 09:00:24 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:65325
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265475AbSLIOAX>; Mon, 9 Dec 2002 09:00:23 -0500
Date: Mon, 9 Dec 2002 09:11:04 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: BUG in 2.5.50
In-Reply-To: <200212091423.40700.roy@karlsbakk.net>
Message-ID: <Pine.LNX.4.50.0212090908330.2139-100000@montezuma.mastecende.com>
References: <200212091056.08860.roy@karlsbakk.net> <200212091236.06966.roy@karlsbakk.net>
 <Pine.LNX.4.50.0212090820250.2139-100000@montezuma.mastecende.com>
 <200212091423.40700.roy@karlsbakk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2002, Roy Sigurd Karlsbakk wrote:

> > Unfortunately for you this currently falls under unsupported
> > configuration.
>
> What's unsupported of it? And then - why do menuconfig allow me to enable both
> TCQ and PREEMPT?

Well i can't speak for Jens wrt TCQ, but IDE and CONFIG_PREEMPT has a few
subtle problems, i have a few pending bugs which are a cause of
preempt and ide not getting along.

	Zwane
-- 
function.linuxpower.ca
