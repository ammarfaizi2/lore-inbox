Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277710AbRJIEEI>; Tue, 9 Oct 2001 00:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277711AbRJIED6>; Tue, 9 Oct 2001 00:03:58 -0400
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:57874 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S277710AbRJIEDs>;
	Tue, 9 Oct 2001 00:03:48 -0400
Date: Tue, 9 Oct 2001 06:04:13 +0200
From: Werner Almesberger <wa@almesberger.net>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011009060413.A29436@almesberger.net>
In-Reply-To: <Pine.GSO.4.30.0110081024440.5473-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0110081024440.5473-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Mon, Oct 08, 2001 at 10:45:02AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> - Linux is already "very modular" as a router with both the traffic
> control framework and netfilter. I like their language specification etc;
> ours is a little more primitive in comparison.

I guess you're talking about iproute2/tc ;-) Things are better with tcng:
http://tcng.sourceforge.net/

Click covers more areas than just Traffic Control, though.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/
