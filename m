Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSKXRte>; Sun, 24 Nov 2002 12:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSKXRtd>; Sun, 24 Nov 2002 12:49:33 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:18053 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261524AbSKXRt3>; Sun, 24 Nov 2002 12:49:29 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 24 Nov 2002 09:57:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Felix von Leitner <felix-kerel@fefe.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: epoll_wait conflicts with man page
In-Reply-To: <20021124174635.GB16255@codeblau.de>
Message-ID: <Pine.LNX.4.50.0211240956500.7401-100000@blue1.dev.mcafeelabs.com>
References: <20021124174635.GB16255@codeblau.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2002, Felix von Leitner wrote:

> I just implemented epoll_create, epoll_ctl and epoll_wait for the diet
> libc and found that epoll_wait in 2.5.59 does not expect struct
> epoll_event* as second argument but actually struct pollfd*.

Man pages are currently under review/editing and the definitive ones
should be ready for the next week.



- Davide

