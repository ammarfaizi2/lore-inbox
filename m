Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbVIOVGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbVIOVGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbVIOVGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:06:17 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40372
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161031AbVIOVGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:06:16 -0400
Date: Thu, 15 Sep 2005 14:06:10 -0700 (PDT)
Message-Id: <20050915.140610.90723126.davem@davemloft.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH]: Brown paper bag in fs/file.c?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050914201550.GB6315@in.ibm.com>
References: <20050914191842.GA6315@in.ibm.com>
	<20050914.125750.05416211.davem@davemloft.net>
	<20050914201550.GB6315@in.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dipankar Sarma <dipankar@in.ibm.com>
Date: Thu, 15 Sep 2005 01:45:50 +0530

> Are you running with preemption enabled ? If so, fyi, I had sent
> out a patch earlier that fixes locking for preemption.
> Also, what triggers this in your machine ? I can try to reproduce
> this albeit on a non-sparc64 box.

Dipankar, don't spend too much effort trying to reproduce my
problem.  I'm back to thinking I might have some kind of sparc64
specific bug on my hands.

Thanks for all of your help.
