Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVBGQeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVBGQeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 11:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVBGQeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 11:34:06 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:58631 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261186AbVBGQeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 11:34:04 -0500
Message-Id: <200502071835.j17IZMlS003456@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Esben Nielsen <simlo@phys.au.dk>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and UML? 
In-Reply-To: Your message of "Mon, 07 Feb 2005 16:08:23 +0100."
             <Pine.OSF.4.05.10502071601480.29801-100000@da410.phys.au.dk> 
References: <Pine.OSF.4.05.10502071601480.29801-100000@da410.phys.au.dk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Feb 2005 13:35:22 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simlo@phys.au.dk said:
> Hi, I am trying to compile and run UM-Linux with PREEMPT_REALTIME. I
> managed to get it to compile but it wont start - it simply stops
> somewhere in start_kernel() :-( 

I've never played with preemption on UML.  No doubt it needs some work...

				Jeff

