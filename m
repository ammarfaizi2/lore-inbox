Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWIZN4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWIZN4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWIZN4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:56:41 -0400
Received: from alpha898.server4you.de ([85.25.133.156]:35277 "EHLO
	alpha1.spitfire-media.de") by vger.kernel.org with ESMTP
	id S1751400AbWIZN4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:56:40 -0400
Message-ID: <4519319E.6070709@obster.org>
Date: Tue, 26 Sep 2006 15:56:46 +0200
From: Michael Obster <lkm@obster.org>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Greg Schafer <gschafer@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 Nasty Lockup
References: <20060926123640.GA7826@tigers.local>
In-Reply-To: <20060926123640.GA7826@tigers.local>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

what do you mean with desktop use? X11-System? Then please add also your
used grafic card and the X11 driver. I see this behaviour with lots of
binary only driver like from NVIDIA or ATI (perhaps they have problems
with the new 2.6.18 kernel).

Just to except that this is the cause for your lock ups.

Kind regards,
Michael Obster

Greg Schafer schrieb:
> This is a _hard_ lockup. No oops, no magic sysrq, no nuthin, just a
> completely dead machine with only option the reset button. Usually happens
> within a couple of minutes of desktop use but is 100% reproducible. Problem
> is still there in a fresh checkout of current Linus git tree (post 2.6.18).
> 
> Dual Athlon-MP 2200's on a Tyan S2466 Tiger MPX. Config attached.
