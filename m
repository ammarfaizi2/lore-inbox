Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270034AbTGUNTF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270047AbTGUNTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:19:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21379 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270034AbTGUNTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:19:04 -0400
Date: Mon, 21 Jul 2003 09:35:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: snoopyzwe <snoopyzwe@sina.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: how to calculate the system idle time
In-Reply-To: <3F1C570E.8080607@sina.com>
Message-ID: <Pine.LNX.4.53.0307210935180.17719@chaos>
References: <3F1C570E.8080607@sina.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003, snoopyzwe wrote:

> I want to implement a module, whose main task is to check the system
> idle time(no keyboard and mouse input) and suspend the whole system(when
> the idle time is long enough). But there comes the problem, how to
> calculate the system idle time. How can I get the time user has no
> operation.
> thanks
> snoopyzwe
>

The the source-code of `top` and review it. Make a user-mode
daemon to watch the system...


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

