Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279628AbRKIHYA>; Fri, 9 Nov 2001 02:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279627AbRKIHXl>; Fri, 9 Nov 2001 02:23:41 -0500
Received: from posta2.elte.hu ([157.181.151.9]:236 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S279617AbRKIHX2>;
	Fri, 9 Nov 2001 02:23:28 -0500
Date: Fri, 9 Nov 2001 09:21:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: "David S. Miller" <davem@redhat.com>, <ak@suse.de>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: speed difference between using hard-linked and modular drives?
In-Reply-To: <3BEB82B8.541558CA@zip.com.au>
Message-ID: <Pine.LNX.4.33.0111090920240.2240-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, Andrew Morton wrote:

> Well on my setup, there are more hash buckets than there are pages in
> the system.  So - basically empty.  If memory serves me, never more
> than two pages in a bucket.

how much RAM and how many buckets are there on your system?

	Ingo


