Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAJV1v>; Wed, 10 Jan 2001 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129903AbRAJV1l>; Wed, 10 Jan 2001 16:27:41 -0500
Received: from 216.41.5.host170 ([216.41.5.170]:27260 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S129431AbRAJV1b>; Wed, 10 Jan 2001 16:27:31 -0500
Message-Id: <200101102127.f0ALRSr01062@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: kernel@ddx.a2000.nu, linux-kernel@vger.kernel.org
Subject: Re: unexplained high load 
In-Reply-To: Your message of "Wed, 10 Jan 2001 22:06:27 +0100."
             <Pine.LNX.4.30.0101102203340.4377-100000@ddx.a2000.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jan 2001 16:27:28 -0500
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>don't think
>w,uptime,top give the same value

The fact that they all give the same value does not indicate that you have not 
been cracked. Obviously, part of the hacking is to cover trails; it'd be a 
pretty poor job if they reported different values.

The mm stuff from your other message is, I think, an indication that you might 
be being hit by a memory management bug that was corrected in 2.2.19pre2.

It is my sincere belief that you will need to upgrade your kernel, but you are 
in no serious danger.

If it's a firewall box, you should be running tripwire or some free variation, 
to help eliminate the possibility that cracking would go undetected.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
