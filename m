Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVLMLOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVLMLOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 06:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVLMLOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 06:14:14 -0500
Received: from dns.toxicfilms.tv ([150.254.220.184]:34477 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S1750811AbVLMLON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 06:14:13 -0500
Date: Tue, 13 Dec 2005 12:14:10 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <459732798.20051213121410@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: 2.6.15-rc5-mm2 :-)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Con,

Tuesday, December 13, 2005, 6:52:09 AM, you wrote:
> I missed this announcement (been on leave for a while). This SCHED_BATCH
> implementation is by Ingo and it it is not "idle" scheduling as I have
> implemented in the staircase scheduler. This is just to restrict a task to
> not having any interactive bonus at any stage and to have predictable 
> scheduling behaviour I guess.
Thanks a lot. That's good anyway.

If I understand correctly, if Ingo's version gets merged with linus' tree
your implementions of SCHED_BATCH in -ck will be replacing the one from Ingo.

A silly question. Is SCHED_BATCH-kind-of-thing a standard in Unices or general
operating system engineering know-how? Or is this concept only available for
Linux?

--
Maciej

