Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265797AbSKRXWx>; Mon, 18 Nov 2002 18:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbSKRXWx>; Mon, 18 Nov 2002 18:22:53 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:30345 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265543AbSKRXWp>; Mon, 18 Nov 2002 18:22:45 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 15:30:11 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unusual scheduling performance
In-Reply-To: <3DD97729.5040803@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0211181529330.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Dave Hansen wrote:

> > So it would appear that eventpoll_release() is the problem.
> > How odd.  You're not actually _using_ epoll there, are you?
>
> Not unless grep uses epoll.

I'd be surprised if it would :)



- Davide


