Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTBLDNd>; Tue, 11 Feb 2003 22:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266805AbTBLDNd>; Tue, 11 Feb 2003 22:13:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27523 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266796AbTBLDNc>; Tue, 11 Feb 2003 22:13:32 -0500
Date: Tue, 11 Feb 2003 19:23:12 -0800
Message-Id: <200302120323.h1C3NCA19787@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Daniel Jacobowitz <dan@debian.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: Linus Torvalds's message of  Tuesday, 11 February 2003 19:10:25 -0800 <Pine.LNX.4.44.0302111904010.2667-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Dynastic imprudent convulsions
   (2) Lingering eruptions
   (3) Reminiscent torrential demolition
   (4) Diabetic rendezvous
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this is even codified in POSIX, but if it isn't, I don't much 
> care: it's also a quality of implementation issue.
> 
> And the simple way to do this right is to not set TIF_SIGPENDING if you 
> don't have to.

There is no argument about this.  Dan and I are talking about real cases
that are definitely specified by POSIX, and you have not responded about them.
