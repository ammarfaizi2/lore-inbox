Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283560AbRK3IYx>; Fri, 30 Nov 2001 03:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283556AbRK3IYr>; Fri, 30 Nov 2001 03:24:47 -0500
Received: from zero.tech9.net ([209.61.188.187]:26379 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S283560AbRK3IYZ>;
	Fri, 30 Nov 2001 03:24:25 -0500
Subject: Re: preempt on sparc64
From: Robert Love <rml@tech9.net>
To: Phil Sorber <aafes@psu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1007108416.8043.11.camel@praetorian>
In-Reply-To: <1007108416.8043.11.camel@praetorian>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 30 Nov 2001 03:24:30 -0500
Message-Id: <1007108671.28315.11.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-30 at 03:20, Phil Sorber wrote:
> Does the preemption patch work on sparc64? I just downloaded the 2.4.16
> kernel and appropriate patches, patched, then make menucondig'd. however
> i didn't find a place to turn that on. then entire menuconfig is
> re-organized under the sparc64 tree, maybe this has something to do with
> it?

We don't have sparc64 support yet, but I'd be happy to take patches :)

Right now we support i386 and ARM.  SH is done and out soon.  Some other
work is ongoing.

	Robert Love

