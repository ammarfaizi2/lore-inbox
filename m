Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263154AbREWQjZ>; Wed, 23 May 2001 12:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263155AbREWQjP>; Wed, 23 May 2001 12:39:15 -0400
Received: from violin.dcs.uky.edu ([204.198.75.11]:10985 "EHLO
	violin.dcs.uky.edu") by vger.kernel.org with ESMTP
	id <S263154AbREWQjJ>; Wed, 23 May 2001 12:39:09 -0400
Date: Wed, 23 May 2001 12:39:08 -0400 (EDT)
From: Srinivasan Venkatraman <srini@dcs.uky.edu>
To: linux-kernel@vger.kernel.org
Subject: How to time in Kernel
In-Reply-To: <5.0.2.1.2.20010428092215.00a68b30@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.10.10105231237210.13795-100000@lisa.dcs.uky.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

 I am trying to time a portion of code inside the kernel. How do I do it?
Can I use do_gettimeofday ? or do_getitimer ? Any leads will be
appreciated.

Thanks in advance,
-Srini.

