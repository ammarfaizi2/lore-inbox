Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbVLZE1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbVLZE1F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 23:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVLZE1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 23:27:05 -0500
Received: from ptil-66-8-in.primus-direct.net ([61.12.8.66]:57544 "EHLO
	agni.dsil.danlawinc.com") by vger.kernel.org with ESMTP
	id S1750996AbVLZE1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 23:27:02 -0500
Subject: GPT & Slice Timer
From: Sushant Kumar Mishra <sushantkumarm@danlawinc.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1135571071.2716.13.camel@suma.dsil.danlawinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 26 Dec 2005 09:54:31 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
I have some questions in my mind.The HZ variable declared in
kernel(param.h 
 
HZ=100) makes it fix that we will get 100 timer interrupts to cpu in a
second.
 
I.e in every 10 ms one timer interrupt.Can u increase HZ value to a
greater 
 
value.As it is HZ=1000 in linux-2.6.Can we go beyond 1000.
 
Another thing i came across GPT & slice timer support in MPC5200.
 
In the source code i couldnot make my self confirmed whether they r used
or 
 
not.In the register definitions i saw register defination related to GPT
but not 
 
related to slice timer in mpc5xxx.h Can you please explain me whether
those 
 
timer can be used or not in writing some kernel code.Plz give some
information 
 
regarding those timer related functions.

