Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRHSDgO>; Sat, 18 Aug 2001 23:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHSDgE>; Sat, 18 Aug 2001 23:36:04 -0400
Received: from waste.org ([209.173.204.2]:14166 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267997AbRHSDfq>;
	Sat, 18 Aug 2001 23:35:46 -0400
Date: Sat, 18 Aug 2001 22:36:00 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>, <riel@conectiva.com.br>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <998190772.8307.8.camel@phantasy>
Message-ID: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2001, Robert Love wrote:

> On 18 Aug 2001 18:41:30 -0500, Oliver Xymoron wrote:
> > Why don't those who aren't worried about whether they _really_ have enough
> > entropy simply use /dev/urandom?
>
> because there still is no entropy.

But your claim is there _is_ entropy. If you think there is, go ahead and
use it. Via /dev/urandom. Yes, I know it's theoretically not secure, but
then neither is what you're proposing.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

