Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266151AbRGLQep>; Thu, 12 Jul 2001 12:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266171AbRGLQef>; Thu, 12 Jul 2001 12:34:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:20235 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266151AbRGLQeS>; Thu, 12 Jul 2001 12:34:18 -0400
Date: Thu, 12 Jul 2001 09:31:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Gunther Mayer <Gunther.Mayer@t-online.de>
cc: <linux-kernel@vger.kernel.org>, <tytso@mit.edu>
Subject: Re: Patch(2.4.6):serial unmaintained (bugfix pci timedia/sunix/exsys
 pci  cards)
In-Reply-To: <3B4DD05F.99C2C71@t-online.de>
Message-ID: <Pine.LNX.4.33.0107120929500.6595-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jul 2001, Gunther Mayer wrote:
>
> this  one-liner fixes a longstanding bug in serial
> for Timedia/Sunix/Exsys PCI cards !

This should already be fixed in 2.4.7-pre6, can you verify that it works
for you?

		Linus

