Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314123AbSEXEDh>; Fri, 24 May 2002 00:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSEXEDg>; Fri, 24 May 2002 00:03:36 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:159 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S314123AbSEXEDe>; Fri, 24 May 2002 00:03:34 -0400
Date: Fri, 24 May 2002 14:06:56 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial - remove unused field
Message-Id: <20020524140656.419a522e.rusty@rustcorp.com.au>
In-Reply-To: <3CED6510.4FB31E7A@daimi.au.dk>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002 23:54:24 +0200
Kasper Dupont <kasperd@daimi.au.dk> wrote:

> This patch removes the unused v86mode field from the
> thread_struct. It was tested against 2.4.19-pre8-ac5,
> and I also verified that 2.5.17 did compile with
> this patch.

<plug>
	Trivial Patch Monkey - trivial at rustcorp.com.au
</plug>

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
