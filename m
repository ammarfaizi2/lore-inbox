Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSLUWA1>; Sat, 21 Dec 2002 17:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265066AbSLUWA1>; Sat, 21 Dec 2002 17:00:27 -0500
Received: from [81.2.122.30] ([81.2.122.30]:45573 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265065AbSLUWAZ>;
	Sat, 21 Dec 2002 17:00:25 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212212218.gBLMIate002167@darkstar.example.net>
Subject: Re: First Bug Found : RE: How to help new comers trying the v2.5x series kernels.
To: sam@ravnborg.org (Sam Ravnborg)
Date: Sat, 21 Dec 2002 22:18:35 +0000 (GMT)
Cc: sampson@attglobal.net, linux-kernel@vger.kernel.org, mec@shout.net,
       zippel@linux-m68k.org
In-Reply-To: <20021221215250.GA1905@mars.ravnborg.org> from "Sam Ravnborg" at Dec 21, 2002 10:52:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The MAINTAINERS file tells you who to contact, (as well as this list):
> > 
> > CONFIGURE, MENUCONFIG, XCONFIG
> > P:      Michael Elizabeth Chastain
> 
> Despite the MAINTANERS file, roman Zippel is the right person to contact.
> roman ripped out three different shell ased parsers and replaced them
> with a single parser written in yacc and c.
> During this process 2make menuconfig" functionality was altered.

Whoops, sorry, I should have realised, especially as I was discussing
that menuconfig problem a couple of weeks ago :-)

John.
