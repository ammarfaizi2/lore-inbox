Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279657AbRJ3ABd>; Mon, 29 Oct 2001 19:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279654AbRJ3ABB>; Mon, 29 Oct 2001 19:01:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16788 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279653AbRJ3AAw>;
	Mon, 29 Oct 2001 19:00:52 -0500
Date: Mon, 29 Oct 2001 16:01:23 -0800 (PST)
Message-Id: <20011029.160123.35683974.davem@redhat.com>
To: bcrl@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011029185743.M25434@redhat.com>
In-Reply-To: <20011029185158.L25434@redhat.com>
	<20011029.155559.64018347.davem@redhat.com>
	<20011029185743.M25434@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Mon, 29 Oct 2001 18:57:44 -0500
   
   See Paul's message.  ia64 does the same thing with hardware walked hashed 
   page tables.  Now, do you want to pay for the 2 days of time you want me 
   to commit to investigating something which is obvious to me?  I don't think 
   so.
   
Why would it take you two days to put together a test case for
something so "trivial"?  Don't be rediculious.

I would be more than happy to pay for the 2 days it's going to take
for you to possibly admit "yeah, maybe it doesn't matter in real life,
sorry". :-)

Franks a lot,
David S. Miller
davem@redhat.com
