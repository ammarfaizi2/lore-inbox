Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTJXUq5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 16:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbTJXUq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 16:46:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56713 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262598AbTJXUq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 16:46:56 -0400
Date: Fri, 24 Oct 2003 16:49:45 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Yaoping Ruan <yruan@cs.princeton.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: mem size at bootup
In-Reply-To: <3F99849D.7CA61D63@cs.princeton.edu>
Message-ID: <Pine.LNX.4.53.0310241646540.29678@chaos>
References: <3F99849D.7CA61D63@cs.princeton.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Oct 2003, Yaoping Ruan wrote:

> Hello,
>
> could anybody tell me if there's any option to specify the size of
> memory I want to use in Linux. We have a box with 4GB memory but we
> would like to run some experiment with only 2GB memory. Is there any
> option like the "hw.physmem" in FreeBSD?
>
> Thanks a lot
>
> - Yaoping Ruan

	mem=16M

...on the LILO command-line will tell Linux to use only 16 megabytes.
You hit the [Alt] key during boot to get to the LILO command-line.
Then you can hit the [Tab] key to see the available systems to boot.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


