Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSKLRPw>; Tue, 12 Nov 2002 12:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSKLRPw>; Tue, 12 Nov 2002 12:15:52 -0500
Received: from [195.110.114.159] ([195.110.114.159]:15143 "EHLO trinityteam.it")
	by vger.kernel.org with ESMTP id <S266615AbSKLRPw>;
	Tue, 12 Nov 2002 12:15:52 -0500
Date: Tue, 12 Nov 2002 18:28:35 +0100 (CET)
From: <ricci@esentar.trinityteam.it>
To: Geoffrey Lee <glee@gnupilgrims.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PDC20276 Linux driver
In-Reply-To: <20021112165309.GB12789@anakin.wychk.org>
Message-ID: <Pine.LNX.4.21.0211121821000.9631-100000@esentar.trinityteam.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Nov 2002, Geoffrey Lee wrote:

> FWIW, we seem to have a not-unsimilar problem.
> 
> Board is a Gigabyte GA-7VRXP which has an on-board Promise 20276.
> Processes get stuck in D after a couple of days,
Sorry for my english, what does couple means? :)

> and kernel log shows
> an invalid NULL deference in find_inode() in fs/inode.c, when it does
> 
> inode->i_ino
> 
> dereference.
> 
> It does not check for whether inode is NULL or not.
> 
> I realize that appears to be valid, because it appears to me that inode
> should never be NULL when it is retrieved from list_entry().

Do u say this because u read list_entry() code, or why?

> 
> I have the ksymoops oops file available, I would be more than happy to
> post that up if anyone wants to take a look.

I would like to help you :) but I have not idea how can I do :(
I would like to debug the kernel but I don't know how to do, can u tell me
a good documentation can I read? Please, please, please.

