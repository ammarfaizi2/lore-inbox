Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268970AbRHRXlj>; Sat, 18 Aug 2001 19:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269395AbRHRXl2>; Sat, 18 Aug 2001 19:41:28 -0400
Received: from waste.org ([209.173.204.2]:35088 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S269491AbRHRXlR>;
	Sat, 18 Aug 2001 19:41:17 -0400
Date: Sat, 18 Aug 2001 18:41:30 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <998156714.2184.55.camel@phantasy>
Message-ID: <Pine.LNX.4.30.0108181839130.31188-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2001, Robert Love wrote:

> obviously some people fear NICs feeding entropy provides a hazard.  for
> those who dont, or are increadibly low on entropy, enable the
> configuration option.

Why don't those who aren't worried about whether they _really_ have enough
entropy simply use /dev/urandom?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

