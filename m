Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSFRSvt>; Tue, 18 Jun 2002 14:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317549AbSFRSvs>; Tue, 18 Jun 2002 14:51:48 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:25307 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S317547AbSFRSvs>; Tue, 18 Jun 2002 14:51:48 -0400
Date: Wed, 19 Jun 2002 04:56:06 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Schwartz <davids@webmaster.com>
Cc: mgix@mgix.com, linux-kernel@vger.kernel.org
Subject: Re: Question about sched_yield()
Message-Id: <20020619045606.3566a8cc.rusty@rustcorp.com.au>
In-Reply-To: <20020618004630.AAA28082@shell.webmaster.com@whenever>
References: <AMEKICHCJFIFEDIBLGOBGEDPCBAA.mgix@mgix.com>
	<20020618004630.AAA28082@shell.webmaster.com@whenever>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002 17:46:29 -0700
David Schwartz <davids@webmaster.com> wrote:
> "The sched_yield() function shall force the running thread to relinquish the 
> processor until it again becomes the head of its thread list. It takes no 
> arguments."

Notice how incredibly useless this definition is.  It's even defined in terms
of UP.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
