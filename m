Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311213AbSCQAjf>; Sat, 16 Mar 2002 19:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311227AbSCQAjZ>; Sat, 16 Mar 2002 19:39:25 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:56780 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311213AbSCQAjM>;
	Sat, 16 Mar 2002 19:39:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: yodaiken@fsmlabs.com, Robert Love <rml@tech9.net>
Subject: Re: 2.4.18 Preempt Freezeups
Date: Sun, 17 Mar 2002 01:33:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
        linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <1016219530.904.21.camel@phantasy> <20020315174036.A5068@hq.fsmlabs.com>
In-Reply-To: <20020315174036.A5068@hq.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16mObg-0000mZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 16, 2002 01:40 am, yodaiken@fsmlabs.com wrote:
> 
> Without preempt:
> 	x = movefrom processor register;
>         do_something with x
> 
> is safe in SMP
> With [preempt] it requires a lock.

It must be a trick question.  Why would it?

-- 
Daniel
