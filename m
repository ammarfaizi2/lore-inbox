Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRKVVTD>; Thu, 22 Nov 2001 16:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281783AbRKVVSw>; Thu, 22 Nov 2001 16:18:52 -0500
Received: from www.wen-online.de ([212.223.88.39]:63246 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S281780AbRKVVSo>;
	Thu, 22 Nov 2001 16:18:44 -0500
Date: Thu, 22 Nov 2001 22:18:29 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Thomas S. Iversen" <thomassi@dina.kvl.dk>
cc: war <war@starband.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Swap vs No Swap.
In-Reply-To: <Pine.LNX.4.21.0111221837030.18891-100000@dirac.dina.kvl.dk>
Message-ID: <Pine.LNX.4.33.0111222140500.663-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Thomas S. Iversen wrote:

> > There is no need for swap if you have enough ram.
>
> Turn it off. How hard can that be?

That was my initial reaction too.  I don't have near the memory
he does and am very satisfied with VM throughput.  I'm seeing
some bad interactivity problems when loading my box while X/KDE
is resident though.. things I don't see in shell land at all.

	-Mike

