Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUFEP13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUFEP13 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 11:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUFEP13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 11:27:29 -0400
Received: from relay01.kbs.net.au ([203.220.32.149]:61115 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S261668AbUFEP1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 11:27:16 -0400
Date: Sun, 6 Jun 2004 1:27:15 +1000
From: "Pods" <pods@dodo.com.au>
To: linux-kernel@vger.kernel.org
Reply-to: "Pods" <pods@dodo.com.au>
Subject: Re: lotsa oops - 2.6.5 (preempt + unable handle virutal address + more?)
X-Priority: 3
X-Mailer: Dodo Internet Webmail Server 
X-Original-IP: 203.221.30.76
Content-Transfer-Encoding: 7BIT
X-MSMail-Priority: Medium
Importance: Medium
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <E1BWd4f-000893-00@mail.kbs.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Run memtest86
Tried once before, didnt boot... died :( memtest page says this happens on
some hardware and they're not sure why.

>> Underclock your system
its not over clocked :/

>> lower IDE DMA mode and see whether it stops oopsing.
tried setting dma = off in hdparm, didnt work, still got crashes compiling
firebird.. infact, it didnt even get passed the ./configure stage :(

Each time (just about, didnt do it once out of 6ish times) i set the dma to
off (either at boot or runtime) i got a "spurious 8259A interript: IRQ 7"..
apparantly, iirc that debug message has been taken out of 2.6.6

Please guys, CC me your responces, otherwise i have to look at some
archives, and reply via webmail... it took 2 firefox crashes (one of which
brought down X) to just right this message... now im going to take a chance
and hit the submit
button

________________________________________________

Message sent using
Dodo Internet Webmail Server

