Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265184AbSKSDui>; Mon, 18 Nov 2002 22:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbSKSDui>; Mon, 18 Nov 2002 22:50:38 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:32142 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265184AbSKSDuh>; Mon, 18 Nov 2002 22:50:37 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 19:58:03 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Grant Taylor <gtaylor+lkml_abbje111802@picante.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ... 
In-Reply-To: <200211190023.gAJ0NZmU001209@habanero.picante.com>
Message-ID: <Pine.LNX.4.44.0211181953300.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Grant Taylor wrote:

> To the coder go the spoils; we'll see what Davide does.  And what
> Linus lets in...

I'm really neutral here, I see pros and cons about the opaque data member.
What I should have pretty much decided right now is to go with EPOLL* bits
and the "struct epollfd" ( Ulrich request ).



- Davide



