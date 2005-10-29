Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVJ2CbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVJ2CbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 22:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVJ2CbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 22:31:04 -0400
Received: from student.if.pw.edu.pl ([194.29.174.5]:22938 "EHLO
	tleilax.if.pw.edu.pl") by vger.kernel.org with ESMTP
	id S1750906AbVJ2CbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 22:31:03 -0400
Date: Sat, 29 Oct 2005 04:30:58 +0200 (CEST)
From: Marek Szuba <cyberman@if.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Still no USB 2.0 with 2.6.14 (on AMD64+nForce4)
Message-ID: <Pine.LNX.4.62.0510290423010.23723@gyrvynk.vs.cj.rqh.cy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Well, the topic says it all: regardless of whichever USB device I plug in, 
it never shows up as a high-speed one using EHCI even if it damn well 
should, and does work in high-speed mode when plugged into the same 
computer while running Win. Unfortunately the workaround I found on 
kerneltrap by googling, i.e. disabling USB 2.0 in BIOS, doesn't work for 
me, even though I have tried all possible combination of related options 
which didn't shut USB down entriely.

Any chance of having this bug fixed soon? Or maybe, since AFAIK the 
problem did not exist before 2.6.10, there is a patch which one could use 
to temporarily restore old behaviour?

As always, if you need any more information about the system in question 
or any other technical details, just let me know; I'm on LKML again right 
now.

Regards,
-- 
MS
