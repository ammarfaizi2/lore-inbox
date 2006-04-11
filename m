Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWDKLe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWDKLe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWDKLe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:34:59 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:54697 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750773AbWDKLe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:34:58 -0400
Date: Tue, 11 Apr 2006 13:34:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vishal Patil <vishpat@gmail.com>
cc: Antonio Vargas <windenntw@gmail.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
In-Reply-To: <4745278c0604090955j2841ebacka990a90ffebc7841@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0604111334150.928@yvahk01.tjqt.qr>
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com> 
 <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com> 
 <4432D6D4.2020102@tmr.com>  <4745278c0604041402n5c6329ebw71d7fdc5c3a9dd68@mail.gmail.com>
  <69304d110604050448x60fd5bb1ub74f66b720dc7d8a@mail.gmail.com> 
 <4745278c0604050646n668bc9fy2b8c18462439ae5d@mail.gmail.com>
 <4745278c0604090955j2841ebacka990a90ffebc7841@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I am attaching the CSCAN scheduler patch for 2.6.16.2 kernel.

Thanks, I will try this.

I have a question, why does not it use the kernel's rbtree implementation?



Jan Engelhardt
-- 
