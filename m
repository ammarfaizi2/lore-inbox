Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSJ2XMP>; Tue, 29 Oct 2002 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbSJ2XMO>; Tue, 29 Oct 2002 18:12:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:53386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262469AbSJ2XMN>;
	Tue, 29 Oct 2002 18:12:13 -0500
Date: Tue, 29 Oct 2002 15:14:57 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Hanna Linder <hannal@us.ibm.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <akpm@digeo.com>
Subject: Re: [Lse-tech] Re: and nicer too - Re: [PATCH] epoll more scalable
 than poll
In-Reply-To: <54690000.1035932769@w-hlinder>
Message-ID: <Pine.LNX.4.33L2.0210291512250.15576-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Hanna Linder wrote:

| --On Tuesday, October 29, 2002 13:41:34 -0800 Davide Libenzi <davidel@xmailserver.org> wrote:
| >>
| >> > Hanna, is it possible for you guys to cleanup ephttpd and make it an
| >> > example program for sys_epoll ?
| >>
| >> You mean for the man page? Sure, I will look into it.
| >
| > Not only for the man page, like a kind-of-reference possible usage ...
|
|
| Would it make sense to put sys_epoll examples in the Documentation
| directory?

You mean in the linux/Documentation/ directory?
No, please don't litter it up like that.

-- 
~Randy

