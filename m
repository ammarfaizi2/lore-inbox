Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282055AbRKZSyO>; Mon, 26 Nov 2001 13:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282065AbRKZSxH>; Mon, 26 Nov 2001 13:53:07 -0500
Received: from dsl-213-023-039-076.arcor-ip.net ([213.23.39.76]:21261 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282066AbRKZSu0>;
	Mon, 26 Nov 2001 13:50:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: <mingo@elte.hu>, Momchil Velikov <velco@fadata.bg>
Subject: Re: [PATCH] Scalable page cache
Date: Mon, 26 Nov 2001 19:52:48 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0111261753480.10763-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E168Qs6-00007Y-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 26, 2001 06:22 pm, Ingo Molnar wrote:
> are you aware of the following patch? (written by David Miller and me.)
> 
>   http://people.redhat.com/mingo/smp-pagecache-patches/pagecache-2.4.10-A3
> 
> it gets rid of the pagecache lock without introducing a tree.

Great.  How?

--
Daniel
