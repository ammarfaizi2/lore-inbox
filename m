Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290030AbSAKReN>; Fri, 11 Jan 2002 12:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290031AbSAKReD>; Fri, 11 Jan 2002 12:34:03 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:39940 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S290030AbSAKRdo>; Fri, 11 Jan 2002 12:33:44 -0500
Date: Fri, 11 Jan 2002 18:33:41 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H4 - 2.4.17 problems
In-Reply-To: <Pine.LNX.4.33.0201111852340.5922-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0201111832110.14335-100000@banaan.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> quick question: your box is not SMP, correct? if it's a UP box then the
> softirq.c change probably makes no difference to the lockup.
OK, just booted (remote) with 2.5.2-pre11-H6 and it works !!!

haven't looked at the patch yet, but is sure fixed it for me ;)
let's hope the same goes for 2.4.x people...


Cheers,
Taco.

