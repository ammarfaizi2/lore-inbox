Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSLCSgT>; Tue, 3 Dec 2002 13:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSLCSgT>; Tue, 3 Dec 2002 13:36:19 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:22716 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265446AbSLCSgQ> convert rfc822-to-8bit; Tue, 3 Dec 2002 13:36:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Exaggerated swap usage
Date: Tue, 3 Dec 2002 19:43:37 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Andrew Clayton <andrew@sol-1.demon.co.uk>,
       Javier Marcet <jmarcet@pobox.com>
References: <200212030059.32018.m.c.p@wolk-project.de> <200212031112.14635.m.c.p@wolk-project.de> <20021203135905.GK1205@dualathlon.random>
In-Reply-To: <20021203135905.GK1205@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212031939.43384.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 December 2002 14:59, Andrea Arcangeli wrote:

Hi Andrea,

> > I run e2fsck -fy every time after a crash. Fortunately it doesn't happen
> > so often :-)
> ok ;) I asked just in case.
:-) np.

> > seems it's a problem in the umount-against-unused-dirty-inodes-race fix
> > or if the fix "is the right way" the problem is located somewhere else
> > what triggers the problem of your patch.
> can you reproduce in 2.4.20aa1 too?
I'll give it a try later this evening.

ciao, Marc
