Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbTLLUYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 15:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTLLUYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 15:24:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261931AbTLLUYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 15:24:33 -0500
Date: Fri, 12 Dec 2003 15:25:12 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Joshua Schmidlkofer <kernel@pacrimopen.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 Boot failure
In-Reply-To: <1071260218.13287.46.camel@bubbles.imr-net.com>
Message-ID: <Pine.LNX.4.53.0312121523510.1500@chaos>
References: <1071260218.13287.46.camel@bubbles.imr-net.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Joshua Schmidlkofer wrote:

> 2.4.23 Hangs just after the boot loader.
>
> This is what I get:
>
> Uncompressing Linux... Ok, booting the kernel.
>
>
> Then nothing.   I have never seen this before.  I do not get any errors,
> it just hangs.
>
> I have been trying to upgrade my server from 2.4.20 to 2.4.23.  This
> server is running the xfs patches from SGI.

This usually means that you selected the wrong CPU type and a bad
opcode (for your CPU) was executed.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


