Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315623AbSEIFvC>; Thu, 9 May 2002 01:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315624AbSEIFvC>; Thu, 9 May 2002 01:51:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:62860 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315623AbSEIFvB>;
	Thu, 9 May 2002 01:51:01 -0400
Date: Thu, 9 May 2002 15:46:55 +1000
From: Anton Blanchard <anton@samba.org>
To: Ken Brownfield <ken@irridia.com>
Cc: Dan Kegel <dank@kegel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yossi@ixiacom.com" <yossi@ixiacom.com>
Subject: Re: khttpd newbie problem
Message-ID: <20020509054655.GB10468@krispykreme>
In-Reply-To: <3CD402D2.E3A94CA2@kegel.com> <20020505005439.GA12430@krispykreme> <3CD4C93D.E543B188@kegel.com> <20020508222119.A12672@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> khttpd is very much production quality on IA32, and has been since
> 2.4.0-test1.  TUX2 is not, however, since under load it enters a 99% CPU
> busy loop.  You may not have enough load to cause TUX2 to do this, and
> TUX1 may not have this problem.

Tux2 has been stable for me on very large specweb runs. Ingo has been
able to fix all the bugs I couldnt - a detailed bug report here would
be helpful.

Anton
