Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264949AbSJPH55>; Wed, 16 Oct 2002 03:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSJPH55>; Wed, 16 Oct 2002 03:57:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:43474 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264949AbSJPH54>;
	Wed, 16 Oct 2002 03:57:56 -0400
Date: Wed, 16 Oct 2002 10:14:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: NPT library mailing list <phil-list@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [patch] mmap-speedup-2.5.42-C3
In-Reply-To: <3DACBD58.AAD8F0A@austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0210161013050.4573-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Oct 2002, Saurabh Desai wrote:

>   Yes, the test_str02 performance improved a lot using NPTL.
>   However, on a side effect, I noticed that randomly my current telnet
>   session was logged out after running this test. Not sure, why?

i think it should be unrelated to the mmap patch. In any case, Andrew
added the mmap-speedup patch to 2.5.43-mm1, so we'll hear about this
pretty soon.

	Ingo

