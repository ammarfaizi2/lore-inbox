Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTIQABk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 20:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTIQABk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 20:01:40 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:25101 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262566AbTIQABj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 20:01:39 -0400
Date: Wed, 17 Sep 2003 02:01:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andries Brouwer <aebr@win.tue.nl>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Another keyboard woes with 2.6.0...
Message-ID: <20030917020136.A1717@pclin040.win.tue.nl>
References: <20030912165044.GA14440@vana.vc.cvut.cz> <Pine.LNX.4.53.0309121341380.6886@montezuma.fsmlabs.com> <20030916232318.A1699@pclin040.win.tue.nl> <Pine.LNX.4.53.0309161844380.23370@montezuma.fsmlabs.com> <Pine.LNX.4.53.0309161911160.23370@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0309161911160.23370@montezuma.fsmlabs.com>; from zwane@linuxpower.ca on Tue, Sep 16, 2003 at 07:12:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 07:12:48PM -0400, Zwane Mwaikambo wrote:

> Here is an excerpt from a KVM switch, ls -l, KVM switch;
> 
> i8042.c: 26 <- i8042 (interrupt, kbd, 1) [150578]: l
> i8042.c: 1f <- i8042 (interrupt, kbd, 1) [150654]: s
> i8042.c: a6 <- i8042 (interrupt, kbd, 1) [150683]: l release
> i8042.c: 39 <- i8042 (interrupt, kbd, 1) [150713]: space
> i8042.c: 9f <- i8042 (interrupt, kbd, 1) [150758]: s release
> i8042.c: 0c <- i8042 (interrupt, kbd, 1) [150789]: -
> i8042.c: b9 <- i8042 (interrupt, kbd, 1) [150853]: space release
> i8042.c: 26 <- i8042 (interrupt, kbd, 1) [150884]: l
> i8042.c: 8c <- i8042 (interrupt, kbd, 1) [150931]: - release
> i8042.c: a6 <- i8042 (interrupt, kbd, 1) [150986]: l release
> i8042.c: 1c <- i8042 (interrupt, kbd, 1) [151090]: enter
> i8042.c: 9c <- i8042 (interrupt, kbd, 1) [151208]: enter release
> i8042.c: 1d <- i8042 (interrupt, kbd, 1) [152374]: LCtrl
> i8042.c: 9d <- i8042 (interrupt, kbd, 1) [152439]: LCtrl release
> i8042.c: 1d <- i8042 (interrupt, kbd, 1) [152653]: LCtrl
> i8042.c: 9d <- i8042 (interrupt, kbd, 1) [152708]: LCtrl release

Thanks!
Nothing disturbing from your switch.


Andries

