Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264993AbRGAGhE>; Sun, 1 Jul 2001 02:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265001AbRGAGgy>; Sun, 1 Jul 2001 02:36:54 -0400
Received: from pizda.ninka.net ([216.101.162.242]:693 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264993AbRGAGgk>;
	Sun, 1 Jul 2001 02:36:40 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15166.50418.583094.554723@pizda.ninka.net>
Date: Sat, 30 Jun 2001 23:36:34 -0700 (PDT)
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org, jakub@redhat.com
Subject: Re: Linux speed on sun4c
In-Reply-To: <20010630220612.C14361@vitelus.com>
In-Reply-To: <20010630220612.C14361@vitelus.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Aaron Lehmann writes:
 > 
 > NetBSD/Sparc's FAQ asserts:
 > 
 >     Why is NetBSD so much faster than SparcLinux on sun4c (top) 
 > 
 >         The memory management hardware on sun4c machines (SPARCStation
 >         1, 1+, 2, IPC, IPX, SLC, ELC and clones) is not handled particularly
 >         well by Linux. Until Linux reworks their MMU code NetBSD will be very
 >         much faster on this hardware. 
 > 
 > Was there ever any truth to this statement? It seems to be light on
 > technical details. Have these purported issues ever been fixed?
 > 
 > I don't want to be scared into running NetBSD on my SparcStation 2 :D.

It's totally true, use *BSD on your sun4c systems if top performance
is your desire. :-)

I know how to fix it but frankly I have no desire to work on
that platform any more.

Later,
David S. Miller
davem@redhat.com
