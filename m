Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314291AbSDRKcZ>; Thu, 18 Apr 2002 06:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314292AbSDRKcY>; Thu, 18 Apr 2002 06:32:24 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:18983 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314291AbSDRKcX>; Thu, 18 Apr 2002 06:32:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Mel <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Subject: Re: page_alloc.c comments patch
Date: Thu, 18 Apr 2002 12:32:18 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0204180306050.4760-100000@skynet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020418103219.3ADBAEC@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 18. April 2002 04:26, Mel wrote:
> This patch is a first cut effort at commenting how the buddy algorithm
> works for allocating and freeing blocks of pages. No code is changed so
> the impact is minimal to put it mildly

Sure?

> -	index = page_idx >> (1 + order);

Nevertheless, great attempt, Mel.

Cheers,
  hp
