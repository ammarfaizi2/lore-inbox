Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264975AbRGAFG3>; Sun, 1 Jul 2001 01:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbRGAFGT>; Sun, 1 Jul 2001 01:06:19 -0400
Received: from vitelus.com ([64.81.36.147]:62724 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S264975AbRGAFGO>;
	Sun, 1 Jul 2001 01:06:14 -0400
Date: Sat, 30 Jun 2001 22:06:12 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org, jakub@redhat.com, davem@redhat.com
Subject: Linux speed on sun4c
Message-ID: <20010630220612.C14361@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NetBSD/Sparc's FAQ asserts:

    Why is NetBSD so much faster than SparcLinux on sun4c (top) 

        The memory management hardware on sun4c machines (SPARCStation
        1, 1+, 2, IPC, IPX, SLC, ELC and clones) is not handled particularly
        well by Linux. Until Linux reworks their MMU code NetBSD will be very
        much faster on this hardware. 

Was there ever any truth to this statement? It seems to be light on
technical details. Have these purported issues ever been fixed?

I don't want to be scared into running NetBSD on my SparcStation 2 :D.
