Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310405AbSBRKfP>; Mon, 18 Feb 2002 05:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310404AbSBRKfG>; Mon, 18 Feb 2002 05:35:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26191 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310397AbSBRKe6>; Mon, 18 Feb 2002 05:34:58 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] Merge e1000 gigabit driver (yay)
In-Reply-To: <3C6E2F92.FD196E71@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Feb 2002 03:30:25 -0700
In-Reply-To: <3C6E2F92.FD196E71@mandrakesoft.com>
Message-ID: <m1wuxb3wvy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> Linus,
> 
> I'm pleased to submit to you a BK merge of Intel's e1000 driver.  The
> license is now "GPL or (BSD + patent grant)", which should satisfy those
> concerns.

Nice progress.
 
> I would also like to publicly thank Intel for this work.  The two
> contributors listed have been very responsive to feedback, and they have
> put a good deal of work into beating the driver into shape for a kernel
> merge.
> 
> Now I just hope I can convince them to open up their hardware specs :)

This is almost as important.  Currently this greatly reduces the value
of their hardware as it places stumbling blocks in road of distributed
debugging.  And the fewer eyes the deeper the bugs.  For that reason
the company I work for has been looking for alternatives to Intel's
network cards. 

Eric
