Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUEFPpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUEFPpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUEFPpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:45:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50309 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262730AbUEFPpu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:45:50 -0400
Date: Thu, 6 May 2004 11:47:51 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Small problem, Can anybody help me?
In-Reply-To: <1118873EE1755348B4812EA29C55A97222F512@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.53.0405061144490.19234@chaos>
References: <1118873EE1755348B4812EA29C55A97222F512@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Srinivas G. wrote:

>
> Hi,
>
> I have written a small hello.c program in the Linux Kernel version
> 2.4.18-3.
>
> The code is as follows.
> -----------------------
>
>
> define MODULE

#define __KERNEL__

#include <linux/kernel.h>

> #include <linux/module.h>
> #include <linux/init.h>
>


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


