Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275383AbRIZRvb>; Wed, 26 Sep 2001 13:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275397AbRIZRvQ>; Wed, 26 Sep 2001 13:51:16 -0400
Received: from chiara.elte.hu ([157.181.150.200]:11020 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275396AbRIZRur>;
	Wed, 26 Sep 2001 13:50:47 -0400
Date: Wed, 26 Sep 2001 19:48:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pagecache SMP locking bug, 2.4.10.
In-Reply-To: <Pine.LNX.4.33.0109261933360.6884-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0109261947450.6377-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> there is a SMP locking bug in 2.4.10's invalidate_list_pages2() [...]

doh, there is no bug.

	Ingo

