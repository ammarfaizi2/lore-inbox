Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277336AbRJEJBZ>; Fri, 5 Oct 2001 05:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277334AbRJEJBP>; Fri, 5 Oct 2001 05:01:15 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:1664 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S277333AbRJEJBA>; Fri, 5 Oct 2001 05:01:00 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200110050901.KAA00306@mauve.demon.co.uk>
Subject: Odd keyboard related crashes.
To: linux-kernel@vger.kernel.org
Date: Fri, 5 Oct 2001 10:01:24 +0100 (BST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.10, and the ps/2 keyboard came out of it's socket.

On plugging back in, all worked fine, until 10 seconds later there was a
crash. (the keyboard worked after being plugged in)
No oops, just a reboot.
Thinking this must just have been a wierd coincidence, after the system
came back up, I tried it again, and again it crashed a few seconds afterwards.

It doesn't seem to want to do this again though.

