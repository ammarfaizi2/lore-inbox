Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280154AbRKEDU0>; Sun, 4 Nov 2001 22:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280162AbRKEDUQ>; Sun, 4 Nov 2001 22:20:16 -0500
Received: from viper.haque.net ([66.88.179.82]:40850 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S280161AbRKEDUG>;
	Sun, 4 Nov 2001 22:20:06 -0500
Date: Sun, 4 Nov 2001 22:20:03 -0500
Subject: Re: disk throughput
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
To: Andrew Morton <akpm@zip.com.au>
From: "Mohammad A. Haque" <mhaque@haque.net>
In-Reply-To: <3BE5F5BF.7A249BDF@zip.com.au>
Message-Id: <00C9ED52-D19C-11D5-8744-00306569F1C6@haque.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sunday, November 4, 2001, at 09:13 PM, Andrew Morton wrote:

> The time to create 100,000 4k files (10 per directory) has fallen
> from 3:09 (3min 9second) down to 0:30.  A six-fold speedup.

Nice.

How long before you release a patch? I have a couple of tasks we execute 
at work I'd like to throw at it.

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                                mhaque@haque.net

   "Alcohol and calculus don't mix.             Developer/Project Lead
    Don't drink and derive." --Unknown          http://wm.themes.org/
                                                batmanppc@themes.org
=====================================================================

