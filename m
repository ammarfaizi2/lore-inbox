Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSHHTUO>; Thu, 8 Aug 2002 15:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317877AbSHHTUN>; Thu, 8 Aug 2002 15:20:13 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:61956 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317874AbSHHTUM>; Thu, 8 Aug 2002 15:20:12 -0400
Date: Thu, 8 Aug 2002 21:23:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Peter Samuelson <peter@cadcamlab.org>
cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <linux-kbuild@lists.sourceforge.net>
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
In-Reply-To: <20020808151432.GD380@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0208082119520.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Aug 2002, Peter Samuelson wrote:

> The real solution (imo) is to add !$CONFIG_FOO support to the config
> language.  Fortunately this is quite easy.  What do you people think?
> I didn't do xconfig or config-language.txt but I can if desired.

I think it would help a lot if you first update the latter and somehow
describe what the negation in this context is supposed to mean.

bye, Roman

