Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318862AbSHLXOW>; Mon, 12 Aug 2002 19:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318867AbSHLXOW>; Mon, 12 Aug 2002 19:14:22 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:9732 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318862AbSHLXOV>; Mon, 12 Aug 2002 19:14:21 -0400
Date: Tue, 13 Aug 2002 01:17:15 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tom Rini <trini@kernel.crashing.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>,
       Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <20020812224704.GG20176@opus.bloom.county>
Message-ID: <Pine.LNX.4.44.0208130053360.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Aug 2002, Tom Rini wrote:

> > A bit more flexibility certainly wouldn't hurt. :)
>
> What does that gain however?  And it wouldn't make as much sense to
> offer the IBM Spruce (750) next to the IBM Walnut (405GP).

You weren't forced to sort them by cpu type. Maybe it works as is, you
should know that better than me.
I only used it as an example, because my tool has problems to
automatically convert this construct into something useful (e.g. because
of CONFIG_WILLOW in 2 seperate choice statements).

bye, Roman

