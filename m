Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTJGAUf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 20:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJGAUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 20:20:34 -0400
Received: from mail1-106.ewetel.de ([212.6.122.106]:41438 "EHLO
	mail1.ewetel.de") by vger.kernel.org with ESMTP id S261763AbTJGAUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 20:20:33 -0400
Date: Tue, 7 Oct 2003 02:20:19 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Andre Hedrick <andre@linux-ide.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: freed_symbols [Re: People, not GPL [was: Re: Driver Model]]
In-Reply-To: <Pine.LNX.4.10.10310061532330.31134-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0310070215470.32013-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Andre Hedrick wrote:

> No it can not, by only using the headers as the functional API for that
> snapshot verson of the kernel release, it is the standard means for
> functionality.

Well, I don't see "standard means for functionality" mentioned anywhere
in the GPL or copyright law (though I'm no expert on that).

If a header contains a macro that expands to real code and a module
has to use that, it means that it absolutely needs that part of kernel
source code to function and then it is a derived work because it
includes GPL'ed code and would not work without it.

> If the macro is require for any driver and or one in the
> kernel to function, and is listed in the headers, it is generally deemed
> to part of the unportected API.

Says who? Who defines what is unprotected API and what is not?

> Again it is very simple declare, all modules which are not GPL and reject
> loading, and we can watch the death of linux as nobody will use it.  Again
> who cares, because it started out as fun for a Finn in 1991, and should
> never be of use or value outside of academics.

Well, silly me, I only buy hardware with open source drivers available.
I wouldn't agree that something is good and has to be done just because
it would improve Linux' "success" (I wouldn't define that to be
commercial success, either).

-- 
Ciao,
Pascal

