Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282478AbRKZUEN>; Mon, 26 Nov 2001 15:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282473AbRKZUCp>; Mon, 26 Nov 2001 15:02:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:51719 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S282474AbRKZUB0>; Mon, 26 Nov 2001 15:01:26 -0500
Date: Mon, 26 Nov 2001 14:54:58 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Zander <mmikael@tupac.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.14 -- BTTV broken???
In-Reply-To: <06WK7.355$m4.9983@news010.worldonline.se>
Message-ID: <Pine.LNX.3.96.1011126145115.27112C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2001, Zander wrote:

> Have you loaded the i2c-core module?

Question. Why is this modules not loaded but the kernel when needed. I
haven't built the bttv stuff yet, I have been warned not to buy anything
for any computer until Dec 26 (personal) or Jan 1 (business), so my bttv
card is not even ordered yet, but I do expect to get one, and I would
expect this to be handled by the loader and depmod.

Or was this a suggestion in case his kernel didn't have auto loading?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

