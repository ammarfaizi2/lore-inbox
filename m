Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSGBWPf>; Tue, 2 Jul 2002 18:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313060AbSGBWPe>; Tue, 2 Jul 2002 18:15:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8437 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S312973AbSGBWPd>; Tue, 2 Jul 2002 18:15:33 -0400
Subject: Re: [PATCH] O(1) scheduler for 2.4.19-rc1
From: Robert Love <rml@tech9.net>
To: venom@sns.it
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0207030007040.30706-100000@cibs9.sns.it>
References: <Pine.LNX.4.43.0207030007040.30706-100000@cibs9.sns.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Jul 2002 15:18:00 -0700
Message-Id: <1025648280.991.1338.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-02 at 15:10, venom@sns.it wrote:

> On 2 Jul 2002, Robert Love wrote:
>
> > As I am the one doing these 2.4 patches, I will invariably be asked
> > whether I intend for the O(1) scheduler to be merged into 2.4.  The
> > answer is a strong NO.
>
> Of course, I think you know that you will also asked WHY?

Because I do not think 2.4 should be a breeding ground for every new
feature that wets someone's appetite.  It should be stable and trusted
before anything else.  We also have to worry about architecture
support.  Let the scheduler be 2.5's thing.

> Also if I can immagine your reasons, as similar discussions have been
> done for preemption patch and so on, and as I said at the times, I Agree.

I do not think preemption should go in 2.4, either.  It too is a 2.5
thing.

> 2.5 is the place for this new and cool stuff.

Agreed.

	Robert Love

