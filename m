Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSJINtq>; Wed, 9 Oct 2002 09:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbSJINtq>; Wed, 9 Oct 2002 09:49:46 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:35588 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261678AbSJINtq>; Wed, 9 Oct 2002 09:49:46 -0400
Date: Wed, 9 Oct 2002 15:55:13 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Jeff Garzik <jgarzik@pobox.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
In-Reply-To: <3DA43094.8040104@pobox.com>
Message-ID: <Pine.LNX.4.44.0210091546070.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 9 Oct 2002, Jeff Garzik wrote:

> Well, my basic preference is
>
> * something other than Config.new (the original name in your config system)
> * something other than Config.in
>
> I think it is a mistake to name a totally different format the same name
> as an older format...  even "config.in" would be better than "Config.in"...

My first plan was to use Config.in, but I can't overwrite the old files
yet, so I named it Config.new. Personally I only prefer that it starts
with a capital letter (like Makefile, Readme), so it's at the top of a
dir listing, but otherwise I don't care much about the name.

bye, Roman

