Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265122AbSJWRnU>; Wed, 23 Oct 2002 13:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265123AbSJWRnU>; Wed, 23 Oct 2002 13:43:20 -0400
Received: from cse.ogi.edu ([129.95.20.2]:27847 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265122AbSJWRnT>;
	Wed, 23 Oct 2002 13:43:19 -0400
To: Dan Kegel <dank@kegel.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Mark Mielke <mark@mark.mielke.cc>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210221231330.1563-100000@blue1.dev.mcafeelabs.com>
	<3DB6D332.9000709@kegel.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 23 Oct 2002 10:49:19 -0700
In-Reply-To: <3DB6D332.9000709@kegel.com>
Message-ID: <xu4y98pjba8.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Kegel <dank@kegel.com> writes:

> Davide Libenzi <davidel@xmailserver.org> wrote:

> I may be confused, but I suspect the async poll being proposed by
> Ben only delivers absolute readiness, not changes in readiness.

> I think epoll is worth having, even if Ben's AIO already handled
> networking properly.

> - Dan

Can someone remind me why poll is needed in the AIO api at all?

How would it be used?

-- Buck








