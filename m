Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291484AbSBUPTw>; Thu, 21 Feb 2002 10:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287200AbSBUPTc>; Thu, 21 Feb 2002 10:19:32 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:17931 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291484AbSBUPTa>; Thu, 21 Feb 2002 10:19:30 -0500
Date: Thu, 21 Feb 2002 16:19:25 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Giacomo Catenazzi <cate@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <3C7504E8.3000604@debian.org>
Message-ID: <Pine.LNX.4.21.0202211610070.2705-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Feb 2002, Giacomo Catenazzi wrote:

> How is the actual symbol range?
> 
> CONFIG_FOO:
>   dep: (FREE? && BEER?)
> 
> how you tell configuration rools that
> FOO can be only min/max of (FREE? && BEER?)

I'm not sure I understand you correctly, but the symbol range in this
example would be from 'n' to min(FREE, BEER).

> I mean: Do you use pythons mode to tell when a
> help description end (no tab: new symbol), few spaces:
> is symbol help or configuration symbols)

There is no new config specification yet, I just dump the information in
the database in a somewhat readable format.

bye, Roman

