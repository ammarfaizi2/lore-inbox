Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313914AbSEFCZq>; Sun, 5 May 2002 22:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314068AbSEFCZp>; Sun, 5 May 2002 22:25:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57997 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313914AbSEFCZp>;
	Sun, 5 May 2002 22:25:45 -0400
Date: Sun, 05 May 2002 19:14:22 -0700 (PDT)
Message-Id: <20020505.191422.11638807.davem@redhat.com>
To: dank@kegel.com
Cc: khttpd-users@alt.org, linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CD5CE35.3EF2B62E@kegel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dan Kegel <dank@kegel.com>
   Date: Sun, 05 May 2002 17:28:37 -0700
   
   If I didn't need it for a demo this week (don't ask), I
   wouldn't be messing with khttpd; I'd be switching to Tux.
   
   Seems like it's time to either fix khttpd or pull it from the kernel.
   
We are going to pull it from the kernel.

The only argument is whether to replace it with TUX or not.
There is a lot of compelling evidence that suggests that
reasonably close performance can be obtained in userspace.

I guess the decision on TUX is not a prerequisite for pulling
khttpd though.
