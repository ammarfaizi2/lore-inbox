Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318713AbSHQSky>; Sat, 17 Aug 2002 14:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318718AbSHQSky>; Sat, 17 Aug 2002 14:40:54 -0400
Received: from bitmover.com ([192.132.92.2]:12960 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318713AbSHQSkx>;
	Sat, 17 Aug 2002 14:40:53 -0400
Date: Sat, 17 Aug 2002 11:44:53 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matt_Domsch@Dell.com, davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 2.5.x] move asm-ia64/efi.h to linux/efi.h
Message-ID: <20020817114453.D27790@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>, Matt_Domsch@Dell.com,
	davej@suse.de, linux-kernel@vger.kernel.org
References: <20BF5713E14D5B48AA289F72BD372D6821CB74@AUSXMPC122.aus.amer.dell.com> <Pine.LNX.4.44.0208171131400.3169-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208171131400.3169-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Aug 17, 2002 at 11:32:49AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linus, please apply
> > http://domsch.com/linux/patches/ia64/linux-2.5-efihmove.cset
> 
> Oh, wow. I thought csets in the email were inconvenient, but cset's on 
> web-sites take the price.
> 
> Please make it a full BK tree to pull from instead, or just include them 
> in the email.

This is starting to be a FAQ so...

The way Linus wants to work with BK is to have a BK tree from which he
can pull when he is ready to accept those changes.  You can set up a
tree at your site if they haven't firewalled everything or you can set
one up on bkbits.net.

The main reason bkbits.net exists is because lots of commercial companies
don't want to have any open ports so there isn't an easy way to make
your tree available.  Since BK works over http there is an easy way for
you to get in/out from the inside but outsiders are stuck.

Go www.bitkeeper.com and click on Hosted Projects, it will tell you how
to set one up.  Let me know if you have problems/questions.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
