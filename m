Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTBAKWs>; Sat, 1 Feb 2003 05:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264756AbTBAKWr>; Sat, 1 Feb 2003 05:22:47 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:27396 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S264749AbTBAKWr>; Sat, 1 Feb 2003 05:22:47 -0500
Date: Sat, 1 Feb 2003 11:31:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Module alias and device table support.
In-Reply-To: <Pine.LNX.4.44.0301312055360.16486-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0302011126420.6646-100000@serv>
References: <Pine.LNX.4.44.0301312055360.16486-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 31 Jan 2003, Kai Germaschewski wrote:

> depmod does give correct warnings, but only at modules install time, not 
> at modules build time, that's what I was trying to say.

depmod certainly could give correct warnings, but currently it doesn't 
because System.map contains not only exported symbols.

bye, Roman

