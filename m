Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUCDNZo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbUCDNZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:25:44 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:29587 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S261887AbUCDNZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:25:43 -0500
Date: Thu, 4 Mar 2004 14:25:38 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@Juliusz
To: =?iso-8859-1?q?Dinesh=20Ahuja?= <mdlinux7@yahoo.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Using the Native POSIX Threading Library (NPTL) instead of
 linuxthreads.
In-Reply-To: <20040304093805.18936.qmail@web8304.mail.in.yahoo.com>
Message-ID: <Pine.GSO.4.58.0403041422140.23652@Juliusz>
References: <20040304093805.18936.qmail@web8304.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, [iso-8859-1] Dinesh Ahuja wrote:

> Hi Everbody,
>
> I am new to Linux world and fascinated with it. I have
> an experience of 2.5 years in C++,C,COM,ATL,VC++ and
> want to get into Linux World.I have build and
> installed Linux Kernel 2.6.0 after struggling for four
> days.
>
> I installed Linux 2.6.0 so that I should be able to
> work with NPTL which is POSIX1.b compliant. But, when
> I see ma for mq_open and mq_close functions, it
> doesn't shows me anything.

POSIX message queues support was just added in -mm tree (it is testing
version of linux kernel available from kernel.org). So after you install
linux-2.6.4-rc1-mmX kernel (and library, from
www.mat.uni.torun.pl/~wroan/posix_ipc - it is very simply) you will have
possibility to use mq_open etc.

Regards
Krzysiek
