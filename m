Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266241AbSKGAVk>; Wed, 6 Nov 2002 19:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266242AbSKGAVk>; Wed, 6 Nov 2002 19:21:40 -0500
Received: from dp.samba.org ([66.70.73.150]:4296 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266241AbSKGAVj>;
	Wed, 6 Nov 2002 19:21:39 -0500
Date: Wed, 6 Nov 2002 12:46:07 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] epoll bits 0.30 ...
Message-Id: <20021106124607.09da5e1c.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0211041939540.956-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0211041939540.956-100000@blue1.dev.mcafeelabs.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002 19:44:29 -0800 (PST)
Davide Libenzi <davidel@xmailserver.org> wrote:

> 
> These are the latest few bits for epoll. Changes :
> 
> *) Some constant adjusted
> 
> *) Comments plus
> 
> *) Better hash initialization

Um, why doesn't this use linux/hash.h?  Haven't looked hard, but...

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
