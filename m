Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272168AbRHWATS>; Wed, 22 Aug 2001 20:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272170AbRHWATJ>; Wed, 22 Aug 2001 20:19:09 -0400
Received: from protactinium.btinternet.com ([194.73.73.176]:34438 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S272168AbRHWATA>;
	Wed, 22 Aug 2001 20:19:00 -0400
Reply-To: <lar@cs.york.ac.uk>
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: 2.4.9 Locks up with multiple video cards and SMP.
Date: Thu, 23 Aug 2001 01:19:19 +0100
Message-ID: <000601c12b69$415a6c50$fa9f7ad5@hayholt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would appreciate some input with my situation.
I have two video cards and a SMP machine.  When I
compile Linux for SMP it always OOPses on boot.
(Search the archives for where.  Basically in vgacon_cursor...)
However, with the same kernel I can boot with
maxcpus=1.  This is the third time I have mentioned
The problem on this mailing list.  Does anyone have 
_any_ information or suggestions?  I have looked through
the init code and everything there appears to be sane.
I would like to track this down because it basically means that I
cannot use Linux.

I can't use a serial console to record the oops,
but what is available I have posted to the mailing list.

Laramie

