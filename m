Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316982AbSGCI5Q>; Wed, 3 Jul 2002 04:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316986AbSGCI5P>; Wed, 3 Jul 2002 04:57:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7866 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316982AbSGCI5P>;
	Wed, 3 Jul 2002 04:57:15 -0400
Date: Wed, 3 Jul 2002 10:57:04 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: fair scheduler hints
In-Reply-To: <1025636058.991.1120.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207031056130.4374-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Jul 2002, Robert Love wrote:

> Even with the fairness implement I am still seeing ~5% improvement with
> a hand full of threads contending over a resource.  Interestingly, I can
> measure an improvement even if only _one_ thread does the hint.  In
> other words, it is fair.

could you post the testcode as well?

	Ingo

