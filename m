Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUCBTvn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 14:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUCBTvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 14:51:43 -0500
Received: from prime.hereintown.net ([141.157.132.3]:55993 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S261751AbUCBTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 14:51:41 -0500
Subject: Re: Better performance with 2.6
From: Chris Meadors <clubneon@hereintown.net>
To: linux-kernel@vger.kernel.org
Cc: root@chaos.analogic.com
In-Reply-To: <Pine.LNX.4.53.0403021406560.1166@chaos>
References: <1078229894.53b994c0albhaf@home.se>
	 <20040302195155.0384abdc.albhaf@home.se>
	 <Pine.LNX.4.53.0403021406560.1166@chaos>
Content-Type: text/plain
Message-Id: <1078257097.7380.31.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 14:51:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 14:10, Richard B. Johnson wrote:

> Are you talking about BogoMips??  This is just how many twinkies
> you can eat in a second with the current coding style in the
> short timer counter. It has absolutely, positively, nothing to
> do with "CPU capacity".

He probably meant MHz.  But the same thing.  What difference does a
tenth of a MHz matter?

I do have a question about BogoMIPS.  I know they don't mean anything,
but why on my Opteron system with two processors that read the same on
the cpu MHz line, do my bogomips vary so much?

processor       : 0
cpu MHz         : 1393.980
bogomips        : 2736.12

processor       : 1
cpu MHz         : 1393.980
bogomips        : 3145.72


-- 
Chris

