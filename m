Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSHZMDh>; Mon, 26 Aug 2002 08:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSHZMC4>; Mon, 26 Aug 2002 08:02:56 -0400
Received: from dsl-213-023-020-192.arcor-ip.net ([213.23.20.192]:35765 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318086AbSHZMCj>;
	Mon, 26 Aug 2002 08:02:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org
Subject: Re: 2.4.19 Vs 2.4.19-rmap14a with anonymous mmaped memory
Date: Mon, 26 Aug 2002 14:08:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208252220030.31523-100000@skynet>
In-Reply-To: <Pine.LNX.4.44.0208252220030.31523-100000@skynet>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17jIfu-0001hg-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 August 2002 00:22, Mel Gorman wrote:
> 4 tests were run on each machine each related to anonymous memory used in
> a mmaped region. Two reference patterns were used. smooth_sin and
> smooth_sin-random . Both sets show a sin curve when the number of times
> each page is referenced is graphed (See the green line in the graph Pages
> Present/Swapped). With smooth_sin, the pages are reffered to in order.
> With smooth_sin-random, the pages are referenced in a random order but the
> amount of times a page is referenced.

Could you please provide pseudocode, to specify these reference patterns
more precisely?

-- 
Daniel
