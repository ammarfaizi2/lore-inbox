Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263052AbTDBQOQ>; Wed, 2 Apr 2003 11:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263053AbTDBQOQ>; Wed, 2 Apr 2003 11:14:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:37255 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263052AbTDBQOP>; Wed, 2 Apr 2003 11:14:15 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Apr 2003 08:23:09 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: loopback behaviour under high load ...
In-Reply-To: <Pine.LNX.4.50.0304011826340.1932-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.50.0304020821250.1758-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0304011826340.1932-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Davide Libenzi wrote:

> And netstat shows Recv-Q=0 for the server socket, and Send-Q=N for the
> client socket. This has been tested on 2.5.66 vanilla.

An update on this. Kernel 2.4.20+epoll does not have this problem.



- Davide

