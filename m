Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318853AbSHLW3y>; Mon, 12 Aug 2002 18:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318854AbSHLW3y>; Mon, 12 Aug 2002 18:29:54 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:33804 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318853AbSHLW3y>; Mon, 12 Aug 2002 18:29:54 -0400
Date: Tue, 13 Aug 2002 00:32:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tom Rini <trini@kernel.crashing.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>,
       Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <20020812221555.GF20176@opus.bloom.county>
Message-ID: <Pine.LNX.4.44.0208130021200.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Aug 2002, Tom Rini wrote:

> > There is still a bit of overlap. Roughly it's possible to sort the machine
> > types by cpu type, but IMO it's not the best solution. I think it would be
> > better to sort them by general machine type.
>
> Er, 'general machine type' ?

+-RPX
| +- ...
+-TQM
| +- ...
+-Motorola
| +- ...
...

A bit more flexibility certainly wouldn't hurt. :)

bye, Roman

