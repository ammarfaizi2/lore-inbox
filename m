Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317187AbSEXPWW>; Fri, 24 May 2002 11:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317188AbSEXPWV>; Fri, 24 May 2002 11:22:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5118 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317187AbSEXPWT>; Fri, 24 May 2002 11:22:19 -0400
Subject: Re: Fix compilation warning in do_mounts.c
From: Robert Love <rml@tech9.net>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <15597.54208.157130.609749@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 24 May 2002 08:22:18 -0700
Message-Id: <1022253738.967.240.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-23 at 22:46, Peter Chubb wrote:

> 	change_floppy() is unused if you don't have the floppy device
> compiled into the kernel --- so why not #ifdef it out?

Heh I was getting to the point of annoyance where I was about to do this
same thing.  Good.

There are a few other similar warnings with other functions, too ... :)

	Robert Love

