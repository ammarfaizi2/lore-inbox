Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTIJFQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTIJFQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:16:48 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:35200 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264629AbTIJFQr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:16:47 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 9 Sep 2003 22:11:24 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Muthukumar <kmuthukumar@mail15.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Introduction
In-Reply-To: <200309100422.h8A4MRc5084257@www.mail15.com>
Message-ID: <Pine.LNX.4.56.0309092209220.924@bigblue.dev.mdolabs.com>
References: <200309100422.h8A4MRc5084257@www.mail15.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Muthukumar wrote:

> Hello all ,
>
> I am working in squid developments oriented works.Then at presently
> i  want to upgrade my kernel to 2.6 for epoll support testing on
> Squid.

It seems you're missing the curses library :

http://www.gnu.org/software/ncurses/ncurses.html

You don't need 2.6 to test epoll though :

http://www.xmailserver.org/linux-patches/epoll-lt-2.4.21-0.18.diff



- Davide

