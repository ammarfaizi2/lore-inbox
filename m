Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262892AbSJAWdU>; Tue, 1 Oct 2002 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbSJAWcm>; Tue, 1 Oct 2002 18:32:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7173 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262892AbSJAWbv>; Tue, 1 Oct 2002 18:31:51 -0400
Date: Tue, 1 Oct 2002 15:39:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Swsusp updates, do not thrash ide disk on suspend
In-Reply-To: <20021001222434.GA2498@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0210011538090.9127-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2 Oct 2002, Pavel Machek wrote:
> 
> This cleans up swsusp a little bit and fixes ide disk corruption on
> suspend/resume. Please apply,

It also seems to be doing things with the device manager. Mind explaining 
those changes too?

		Linus

