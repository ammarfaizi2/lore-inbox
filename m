Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135249AbRDZJnC>; Thu, 26 Apr 2001 05:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135251AbRDZJmw>; Thu, 26 Apr 2001 05:42:52 -0400
Received: from www.wen-online.de ([212.223.88.39]:6670 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S135249AbRDZJmp>;
	Thu, 26 Apr 2001 05:42:45 -0400
Date: Thu, 26 Apr 2001 11:42:17 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104260421480.1267-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0104261135450.348-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Marcelo Tosatti wrote:

> Have you tried to tune SWAP_SHIFT and the priority used inside swap_out()
> to see if you can make pte deactivation less aggressive ?

Many many many times.. no dice.

(more agressive is much better for surge regulation.. power brakes!)

	-Mike

