Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267144AbTBICWQ>; Sat, 8 Feb 2003 21:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbTBICWQ>; Sat, 8 Feb 2003 21:22:16 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54165 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267144AbTBICWQ>; Sat, 8 Feb 2003 21:22:16 -0500
Date: Sat, 8 Feb 2003 18:31:47 -0800
Message-Id: <200302090231.h192Vlc04229@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: Linus Torvalds's message of  Saturday, 8 February 2003 18:19:12 -0800 <Pine.LNX.4.44.0302081817001.7675-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
X-Windows: flawed beyond belief.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, I'll code up the SIGKILL changes that should make this a non-issue 

I'm already in the midst of those and will test my various cases and gdb
and so forth.  If you want to put something in before I've done testing,
then please send me the patch you use.

