Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265215AbRF0Ba4>; Tue, 26 Jun 2001 21:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265218AbRF0Bar>; Tue, 26 Jun 2001 21:30:47 -0400
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:4736
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S265215AbRF0Bam>; Tue, 26 Jun 2001 21:30:42 -0400
Date: Tue, 26 Jun 2001 18:30:14 -0700
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200106270130.f5R1UEW01001@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: shaas@vibe.com, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6 Pre 5 Not see all available RAM
In-Reply-To: <002a01c0fe9f$ecc73fb0$6900a8c0@STUARTHAASW2K>
In-Reply-To: <002a01c0fe9f$ecc73fb0$6900a8c0@STUARTHAASW2K>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> I have discovered that while running 2.4.6pre5, the kernel does not
> see all available RAM - I have 1GB and the kernel only sees ~899MB.

The 1GB memory option in the kernel configuration is really the 896MB
memory option.  So for more than 896MB, you need to select the 4GB
memory option, which really is 4GB.

Wayne

