Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266265AbUA2TEC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUA2TEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:04:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266265AbUA2TEA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:04:00 -0500
Date: Thu, 29 Jan 2004 14:03:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Satheesh Kumar <nksk76@yahoo.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel compilation : make modules fails
In-Reply-To: <20040129185401.12454.qmail@web41010.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0401291359140.521@chaos>
References: <20040129185401.12454.qmail@web41010.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004, Satheesh Kumar wrote:

> Hi,
>
> I installed a fresh RedHat 9.0 distribution on my
> system. I'm trying to compile kernel with a new
> driver. The compilation steps I'm following are as
> below:
> * make oldconfig
> * make dep
> * make bzImage
> * make modules
> * make modules_install
>
> Till 'make bzImage' everything succeeds. However,
> 'make modules' fails.
>
> Can someone help me out with this? Are there any known
> problems and solutions wit RH9.0 distribution of the
> kernel sources? The kernel version is 2.4.20.
>

Some kind of hint on how `make modules` fails? Clearly both
2.4.20 and the RH9 distribution works okay for others.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


