Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265097AbSKESxL>; Tue, 5 Nov 2002 13:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265088AbSKESxK>; Tue, 5 Nov 2002 13:53:10 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265084AbSKESxJ>; Tue, 5 Nov 2002 13:53:09 -0500
Date: Tue, 5 Nov 2002 13:59:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?will=20fitzgerald?= <linux_learning@yahoo.co.uk>
cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: important how to stop interrupts and start them again after finishing what you wanted to do??
In-Reply-To: <20021105173555.88591.qmail@web13102.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1021105135903.410B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Nov 2002, [iso-8859-1] will fitzgerald wrote:

> Hi all,
> 
> does any know how i can stop and start interrupts.
> 
[SNIPPED...]

`grep` kernel driver code for spinlock.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


