Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUBIN6x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUBIN6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:58:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16770 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265207AbUBIN6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:58:52 -0500
Date: Mon, 9 Feb 2004 09:00:24 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nick Craig-Wood <ncw1@axis.demon.co.uk>
cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
In-Reply-To: <20040209134005.GA15739@axis.demon.co.uk>
Message-ID: <Pine.LNX.4.53.0402090853020.8894@chaos>
References: <c07c67$vrs$1@terminus.zytor.com> <20040209092915.GA11305@axis.demon.co.uk>
 <20040209124739.GC1738@mail.shareable.org> <20040209134005.GA15739@axis.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Feb 09, 2004 at 07:17:27AM +0000, H. Peter Anvin wrote:
> > Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?

Only people who want to log-in from the network..... Of course
you could force a re-write of all the stuff like telnet, adding
another layer of bugs that'll take another N years to find and
remove.

I think you really need to leave the "legacy" stuff alone. Somebody
installs a new kernel and then can't log in from the Network. Not
good at all.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


