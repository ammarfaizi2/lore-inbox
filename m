Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTFKRhe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 13:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTFKRhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 13:37:34 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:33178 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S263587AbTFKRfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 13:35:41 -0400
From: Artemio <artemio@artemio.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SMP question
Date: Wed, 11 Jun 2003 20:43:11 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306112043.11923.artemio@artemio.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have the following question.

My system is 2x 2.4Ghz Xeons.

Linux kernel 2.4.18 compiled with SMP support sees it as four processors. 
SMP-disabled kernel sees one, of course.

I would like to know, how will it influence the system performance, if I run a 
UP kernel?

What does the kernel SMP support add? Just some API for additinal 
multiprocessor control? Will the SMP-enabled kernel run faster than the UP 
one?

That's what I would like to know.



Thanks!


Artemio.

