Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291547AbSCWDQj>; Fri, 22 Mar 2002 22:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSCWDQa>; Fri, 22 Mar 2002 22:16:30 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59405 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291547AbSCWDQV>; Fri, 22 Mar 2002 22:16:21 -0500
Date: Fri, 22 Mar 2002 22:14:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: James Bourne <jbourne@MtRoyal.AB.CA>
cc: Davide Libenzi <davidel@xmailserver.org>,
        David Schwartz <davids@webmaster.com>, joeja@mindspring.com,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: max number of threads on a system
In-Reply-To: <Pine.LNX.4.44.0203220840280.14699-100000@skuld.mtroyal.ab.ca>
Message-ID: <Pine.LNX.3.96.1020322221213.24536A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, James Bourne wrote:

> One thing to note here, using pthreads there is a limit of 1024
> threads per process.  There are patches to glibc to increase this
> to a larger number (4096 or 8192).

  Haven't checked to see the limit in NGPT, but I haven't hit it ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

