Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135577AbRDXMwH>; Tue, 24 Apr 2001 08:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135579AbRDXMv5>; Tue, 24 Apr 2001 08:51:57 -0400
Received: from viper.haque.net ([66.88.179.82]:48306 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S135577AbRDXMvm>;
	Tue, 24 Apr 2001 08:51:42 -0400
Message-ID: <3AE576D1.18B857A1@haque.net>
Date: Tue, 24 Apr 2001 08:51:29 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: imel96@trustix.co.id
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104241830020.11899-100000@tessy.trustix.co.id>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co.id wrote:
> 
> hi,
> 
> a friend of my asked me on how to make linux easier to use
> for personal/casual win user.
> 
> i found out that one of the big problem with linux and most
> other operating system is the multi-user thing.
> 
> i think, no personal computer user should know about what's
> an operating system idea of a user. they just want to use
> the computer, that's it.
> 
> by a personal computer i mean home pc, notebook, tablet,
> pda, and communicator. only one user will use those devices,
> or maybe his/her friend/family. do you think that user want
> to know about user account?
> 
> from that, i also found out that it is very awkward to type
> username and password every time i use my computer.

Sounds to me like you really don't get the whole concept of permissions
and that it's how Unix works.

Besides, why should the kernel do anythign different for you when there
are userland tools that you can use to have the system auto-login as a
specified user?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
