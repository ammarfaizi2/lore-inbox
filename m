Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSJNO6P>; Mon, 14 Oct 2002 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbSJNO6P>; Mon, 14 Oct 2002 10:58:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49835 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261703AbSJNO6O>;
	Mon, 14 Oct 2002 10:58:14 -0400
Date: Mon, 14 Oct 2002 17:15:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support,
 2.5.42-F8
In-Reply-To: <Pine.LNX.4.44.0210141642160.3474-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210141712180.8223-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And which hashing comments do you mean? We still hash pagecache pages.

i see, indeed those comments (and other comments in filemap.c) should
refer to the radix tree, although people do keep think about it as a hash
:-)

	Ingo

