Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbTCSXxk>; Wed, 19 Mar 2003 18:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263278AbTCSXxk>; Wed, 19 Mar 2003 18:53:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42411 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263276AbTCSXxb>;
	Wed, 19 Mar 2003 18:53:31 -0500
Date: Wed, 19 Mar 2003 16:02:50 -0800 (PST)
Message-Id: <20030319.160250.42440240.davem@redhat.com>
To: hpa@zytor.com
Cc: mirrors@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E78D0DE.307@zytor.com>
References: <3E78D0DE.307@zytor.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "H. Peter Anvin" <hpa@zytor.com>
   Date: Wed, 19 Mar 2003 12:19:42 -0800

   Now, the questions that come up are:
   
   i) Does this sound reasonable to everyone?  In particular, is there any
   loss in losing the "original" compressed files?
   
   ii) Assuming a yes on the previous question, what time frame would it
   make sense for this changeover to happen over?

I'm fine with this, and my personal feeling on time is the sooner
the better.

It's pretty hard to find a Linux system without bzip2 these days.
