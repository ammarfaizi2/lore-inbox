Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSHBGAK>; Fri, 2 Aug 2002 02:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSHBGAK>; Fri, 2 Aug 2002 02:00:10 -0400
Received: from www.transvirtual.com ([206.14.214.140]:20235 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S318277AbSHBGAK>; Fri, 2 Aug 2002 02:00:10 -0400
Date: Thu, 1 Aug 2002 23:03:27 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Ivan Gyurdiev <ivangurdiev@attbi.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.30
In-Reply-To: <200207312330.31101.ivangurdiev@attbi.com>
Message-ID: <Pine.LNX.4.44.0208012302090.29483-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The following trivial patches are still missing from the kernel:
>
> 	 - devfs patch to fix the problem with missing virtual consoles - only 0 in
> /dev/vc: drivers/char/console.c

Try out my console patch at

http://www.transvirtual.com/~jsimmons/console.diff.gz

Please tell me if it solves the problem. I waiting for someone to say it
works then I will push my BK stuff to Linus.


