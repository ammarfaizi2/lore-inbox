Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263986AbSKRSwk>; Mon, 18 Nov 2002 13:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSKRSwk>; Mon, 18 Nov 2002 13:52:40 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:26758 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263986AbSKRSwf>; Mon, 18 Nov 2002 13:52:35 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 10:59:59 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unusual scheduling performance
In-Reply-To: <3DD937CB.2030304@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0211181059160.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Dave Hansen wrote:

> > If you're not using epoll and you get there, someone is screwing up the
> > data inside the struct file
>
> That little tidbit isn't even in .47.  Is that patch against one of
> the 2.5.47-mm's?

No Andrew took it from 2.5.48 ...



- Davide


