Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTLUViW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 16:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbTLUViW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 16:38:22 -0500
Received: from cvg-65-27-129-24.cinci.rr.com ([65.27.129.24]:39419 "EHLO
	dragon.CyberneticEvolution.com") by vger.kernel.org with ESMTP
	id S264129AbTLUViU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 16:38:20 -0500
Date: Sun, 21 Dec 2003 16:38:20 -0500 (EST)
From: "Dhananjai M. Rao" <dmadhava@djrao.com>
X-X-Sender: <dmadhava@dragon.CyberneticEvolution.com>
To: <linux-kernel@vger.kernel.org>
Subject: Concurrent multiple Virtual Consoles using 2 video cards + 2 monitors
Message-ID: <Pine.LNX.4.33.0312211637470.9427-100000@dragon.CyberneticEvolution.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to figure out how to configure 2 concurrently active virtual
consoles (just text-based ones and not using X with xinearama extensions
etc.) on the Linux kernel.

I am trying to do this on a Athlon/XP machine running Linux kernel 2.4.20
(distributed with Red Hat 9.0 stock) and I have 1 AGP video card (nVidia
GeForce) and 1 PCI video card (S3ViRGE) and 2 monitors connected to the
two video cards.  When the machine boots up (into runlevel 3), only one
monitor (the PCI video card) is active and the other monitor is not used.
[However, when I start-up X (with suitable configuration), both monitors
work fine]

I would like to have 2 concurrent virtual consoles running on the two
monitors simultaneously.  How do I setup virtual consoles to achieve this?
I am guessing if I can get two virtual consoles working simultaneously?

Any tips, suggestions, or pointers to other resources are welcome.

thanks in advance for your time and patience for responding to this
request.

with regards and seasons greetings
-DJ

