Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317296AbSFCH25>; Mon, 3 Jun 2002 03:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317297AbSFCH25>; Mon, 3 Jun 2002 03:28:57 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:35791 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317296AbSFCH24>; Mon, 3 Jun 2002 03:28:56 -0400
Date: Mon, 3 Jun 2002 17:32:44 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dan Aloni <da-x@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache.{c,h} cleanup
Message-Id: <20020603173244.5a36cb75.rusty@rustcorp.com.au>
In-Reply-To: <20020531082806.GA4053@callisto.yi.org>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2002 11:28:06 +0300
Dan Aloni <da-x@gmx.net> wrote:

> include/linux/dcache.h:

You should break these down to one per file, and send them to the VFS
maintainer.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
