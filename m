Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTBIEus>; Sat, 8 Feb 2003 23:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTBIEur>; Sat, 8 Feb 2003 23:50:47 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47543 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267174AbTBIEur>; Sat, 8 Feb 2003 23:50:47 -0500
Date: Sat, 8 Feb 2003 21:00:13 -0800
Message-Id: <200302090500.h1950D305483@magilla.sf.frob.com>
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
In-Reply-To: Linus Torvalds's message of  Saturday, 8 February 2003 20:51:05 -0800 <Pine.LNX.4.44.0302082049420.4686-100000@penguin.transmeta.com>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Miraculous perilous bag lunches
   (2) Enormous goat circumcisions
   (3) Vigorous indigestion selectors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like kernel threads still go crazy at shutdown. I saw the migration 
> threads apparently hogging the CPU.

Hmm, my (2-CPU) machine reboots quickly.  I'd have to be checking closely
somehow to see if there is some short period of weird hoggery (I'm not sure
how, since my fingers aren't quick enough).  What exactly did you observe,
and how?


Thanks,
Roland
