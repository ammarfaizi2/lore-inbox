Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264608AbSIVX1C>; Sun, 22 Sep 2002 19:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264609AbSIVX1C>; Sun, 22 Sep 2002 19:27:02 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:28935 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264608AbSIVX1B>; Sun, 22 Sep 2002 19:27:01 -0400
Date: Mon, 23 Sep 2002 01:30:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
In-Reply-To: <Pine.LNX.4.44.0209221813430.11808-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0209230128250.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 22 Sep 2002, Kai Germaschewski wrote:

> I'm still not happy at least for the ".config does not exist" case. Since
> when I forget to "cp ../config-2.5 .config", I don't really want "make
> oldconfig", I want to do the forgotten cp.

Adding this check to the silent mode is trivial.

bye, Roman

