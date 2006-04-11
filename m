Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWDKLjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWDKLjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 07:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWDKLjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 07:39:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40484 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750777AbWDKLjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 07:39:07 -0400
Date: Tue, 11 Apr 2006 13:39:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Vishal Patil <vishpat@gmail.com>, Antonio Vargas <windenntw@gmail.com>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
Message-ID: <20060411113926.GD4791@suse.de>
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com> <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com> <4432D6D4.2020102@tmr.com> <4745278c0604041402n5c6329ebw71d7fdc5c3a9dd68@mail.gmail.com> <69304d110604050448x60fd5bb1ub74f66b720dc7d8a@mail.gmail.com> <4745278c0604050646n668bc9fy2b8c18462439ae5d@mail.gmail.com> <4745278c0604090955j2841ebacka990a90ffebc7841@mail.gmail.com> <Pine.LNX.4.61.0604111334150.928@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604111334150.928@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11 2006, Jan Engelhardt wrote:
> 
> >I am attaching the CSCAN scheduler patch for 2.6.16.2 kernel.
> 
> Thanks, I will try this.
> 
> I have a question, why does not it use the kernel's rbtree implementation?

It does, I dunno why you think it doesn't?

-- 
Jens Axboe

