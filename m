Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265056AbSKFN0D>; Wed, 6 Nov 2002 08:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSKFN0C>; Wed, 6 Nov 2002 08:26:02 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:55559 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265056AbSKFN0B>; Wed, 6 Nov 2002 08:26:01 -0500
Date: Wed, 6 Nov 2002 14:32:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Up silly limit on .config line length
In-Reply-To: <20021105233844.J24606@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211061425280.6949-100000@serv>
References: <20021105233844.J24606@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 5 Nov 2002, Russell King wrote:

> I believe that this arbitary limit should be eliminated by some method.
> However, as a "get you working" patch with a new arbitary limit of 1024
> characters:

I was already wondering, how much I should allow. :)
But I'd rather set an arbitrary limit (and warn) than allowing an 
arbitrary long string.

bye, Roman

