Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbTCIUID>; Sun, 9 Mar 2003 15:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbTCIUID>; Sun, 9 Mar 2003 15:08:03 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:61966 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262596AbTCIUIB>; Sun, 9 Mar 2003 15:08:01 -0500
Date: Sun, 9 Mar 2003 21:18:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig update
In-Reply-To: <20030309193439.GA15837@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0303092115310.32518-100000@serv>
References: <Pine.LNX.4.44.0303090432200.32518-100000@serv>
 <20030309190103.GA1170@mars.ravnborg.org> <Pine.LNX.4.44.0303092028020.32518-100000@serv>
 <20030309193439.GA15837@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Mar 2003, Sam Ravnborg wrote:

> It is only present in linus-BK-latest - sorry.
> "make V=0" is a shorthand for "make KBUILD_VERBOSE=0".
> In other words a way to disable the 'noise' generated
> when building the kernel.

I still don't see what you mean. :)
Which noise exactly do you want to disable? With "make KBUILD_VERBOSE=0" I 
only see normal build messages.

bye, Roman

