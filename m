Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318166AbSHDQwW>; Sun, 4 Aug 2002 12:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318167AbSHDQwW>; Sun, 4 Aug 2002 12:52:22 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:24714 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318166AbSHDQwW>; Sun, 4 Aug 2002 12:52:22 -0400
Date: Sun, 4 Aug 2002 18:55:55 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Thunder from the hill <thunder@ngforever.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rmap speedup
In-Reply-To: <Pine.LNX.4.44.0208040809470.10270-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0208041854080.25745-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Aug 2002, Thunder from the hill wrote:

> Hi,
> 
> On Sun, 4 Aug 2002, Daniel Phillips wrote:
> > Look again: 256 - 16 = 250 = 0xf0.
> 
> What's your maths?! 256d - 16d = 0xff - 0xf = 0xf0 = 240d!

What's yours?! 256d - 16d = 0x100 - 0x10 = 0xf0 = 240d!

Couldn't resist... ;-)

/Tobias

