Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbTCZSZy>; Wed, 26 Mar 2003 13:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbTCZSZy>; Wed, 26 Mar 2003 13:25:54 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:47365 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261835AbTCZSZx>; Wed, 26 Mar 2003 13:25:53 -0500
Date: Wed, 26 Mar 2003 18:37:05 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Michael Dreher <dreher@math.tu-freiberg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 double display
In-Reply-To: <200303260012.51560.dreher@math.tu-freiberg.de>
Message-ID: <Pine.LNX.4.44.0303261836230.18664-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello all,
> 
> I tried 2.5.66 now, and X is unusable. Everything is displayed twice.
> There is a vertical split in the middle, and the right half is
> identical to the left half. For instance, I have two half 
> login prompts of kdm. I attach my .config.

You have VESA framebuffer AND the ATI 128 driver enabled. Turn one of them 
off.


