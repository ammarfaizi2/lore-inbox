Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261663AbSJ2DW0>; Mon, 28 Oct 2002 22:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261665AbSJ2DW0>; Mon, 28 Oct 2002 22:22:26 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:18590 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261663AbSJ2DWZ>; Mon, 28 Oct 2002 22:22:25 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 19:38:11 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: Security critical race condition in epoll code
In-Reply-To: <3DBDE8AF.6090102@netscape.com>
Message-ID: <Pine.LNX.4.44.0210281935040.1002-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, John Gardiner Myers wrote:

> Thread A then runs some more and stores the value of events into the now
> freed block of memory pointed to by dpi.

Thank you very much for your input John, I really appreciate :

http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-last.diff

If you have any other complain, pls let me know ...



- Davide


