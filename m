Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273691AbRJTRCa>; Sat, 20 Oct 2001 13:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273783AbRJTRCU>; Sat, 20 Oct 2001 13:02:20 -0400
Received: from zero.tech9.net ([209.61.188.187]:10515 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S273691AbRJTRCI>;
	Sat, 20 Oct 2001 13:02:08 -0400
Subject: Re: [PATCH] updated preempt-kernel
From: Robert Love <rml@tech9.net>
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20011020145906.01f60a00@pop.tiscalinet.it>
In-Reply-To: <3.0.6.32.20011020145906.01f60a00@pop.tiscalinet.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 20 Oct 2001 13:02:43 -0400
Message-Id: <1003597363.866.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-20 at 08:59, Lorenzo Allegrucci wrote:
> At 03.27 20/10/01 -0400, Robert Love wrote:
>
> >* reapply dropped hunk to pgalloc to prevent reentrancy onto per-CPU
> >data
> 
> This above seems to have fixed some spontaneous reboots and oopses
> I experiencied with 2.4.11 and 2.4.12-1 preempt-kernel patches.
 
This is very much what I wanted to hear.  Thank you.  I was hoping to
clear those issues up.  Let me know of any other problems.  Enjoy.

	Robert

