Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSLQQ6f>; Tue, 17 Dec 2002 11:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265132AbSLQQ6e>; Tue, 17 Dec 2002 11:58:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8459 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265126AbSLQQ6e>; Tue, 17 Dec 2002 11:58:34 -0500
Date: Tue, 17 Dec 2002 09:07:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212171556110.1460-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212170906420.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Hugh Dickins wrote:
>
> I thought that last page was intentionally left invalid?

It was. But I thought it made sense to use, as it's the only really
"special" page.

But yes, we should decide on this quickly - it's easy to change right now,
but..

		Linus

