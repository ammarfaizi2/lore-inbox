Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbSKRXNR>; Mon, 18 Nov 2002 18:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSKRXNQ>; Mon, 18 Nov 2002 18:13:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:27273 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265246AbSKRXNO>; Mon, 18 Nov 2002 18:13:14 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 15:20:41 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <3DD97A3D.2030909@kegel.com>
Message-ID: <Pine.LNX.4.44.0211181520140.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Dan Kegel wrote:

> > The interface ( edge-triggered ) is quite different and we saw in the
> > previous experience how this might lead to confusion for the user. Putting
> > epoll bits inside poll.h will IMHO increase this.
>
> The only difference is the edge-triggered nature, though, right?

Yes, but we have seen that it's enough :)



- Davide


