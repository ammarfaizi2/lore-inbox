Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWANUZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWANUZs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 15:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWANUZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 15:25:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751074AbWANUZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 15:25:47 -0500
Date: Sat, 14 Jan 2006 12:25:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: chaosite@gmail.com
Cc: daviado@gmail.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       drepper@gmail.com, robustmutexes@lists.osdl.org
Subject: Re: Robust futex patch for Linux 2.6.15
Message-Id: <20060114122521.39f86ed5.akpm@osdl.org>
In-Reply-To: <43C9233A.20504@gmail.com>
References: <b324b5ad0601131316m721f959eu37b741f9e5557a2e@mail.gmail.com>
	<20060113132704.207336d7.akpm@osdl.org>
	<43C9233A.20504@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matan Peled <chaosite@gmail.com> wrote:
>
> Andrew, I'm looking at this:
> 
>  http://source.mvista.com/~dsingleton/robust-futex-1
> 
>  And it doesn't seem to have a futex_deadlock function at all. In fact, its seems 
>  to have a rather lengthy description about robust futexes and why they're a Good 
>  Thing(TM).
> 
>  What are you looking at?

A file which now appears to have been deleted..
