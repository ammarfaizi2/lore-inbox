Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319681AbSIMPCx>; Fri, 13 Sep 2002 11:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319682AbSIMPCx>; Fri, 13 Sep 2002 11:02:53 -0400
Received: from mnh-1-17.mv.com ([207.22.10.49]:59652 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S319681AbSIMPCw>;
	Fri, 13 Sep 2002 11:02:52 -0400
Message-Id: <200209131612.LAA02596@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net,
       Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>
Subject: Re: [reiserfs-dev] Re: UML 2.5.34 
In-Reply-To: Your message of "Fri, 13 Sep 2002 17:31:24 +0400."
             <15745.59564.28543.921212@laputa.namesys.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Sep 2002 11:12:12 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita@Namesys.COM said:
> pte_addr_t and CLOCK_TICK_RATE were undefined. 

Undefined WHERE?  You could send me a snippet of your build log.

> By the way, I am talking about Linus BK tree, rather than patches you
> have posted.

I would not have sent it to Linus if it didn't build.  Like I said, it builds
here fine.  I want to know where it breaks, so I can see it for myself, so
I can be sure the fix is right.

				Jeff

