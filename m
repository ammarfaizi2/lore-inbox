Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSHXAvd>; Fri, 23 Aug 2002 20:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314634AbSHXAvd>; Fri, 23 Aug 2002 20:51:33 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:34234 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S314602AbSHXAvd>;
	Fri, 23 Aug 2002 20:51:33 -0400
Message-ID: <1030150543.3d66d98f63c45@kolivas.net>
Date: Sat, 24 Aug 2002 10:55:43 +1000
From: conman@kolivas.net
To: Kurt Johnson <gorydetailz@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: performance patch for 2.4.19
References: <20020823161337.81396.qmail@web14605.mail.yahoo.com>
In-Reply-To: <20020823161337.81396.qmail@web14605.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kurt Johnson <gorydetailz@yahoo.co.uk>:

> I was wondering, are considering mergint the -aa VM
> patches in your performance patch for 2.4.19? IMHO,
> lowish-end machines (desktop machines and smaller
> boxes) have notorious gains with -aa VM compared to
> Rik's -rmap, so it'd be interesting to see how a combo
> of O(1)+preempt+low_lat+aa would perform. Just a
> thought, tho. Thanks for your work integrating all the
> patches, it sure helps a lot!

My pleasure. I might try a -rmap and -aa extension.
