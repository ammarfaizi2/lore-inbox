Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSGVUgl>; Mon, 22 Jul 2002 16:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317791AbSGVUgl>; Mon, 22 Jul 2002 16:36:41 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:4493 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S317778AbSGVUgk>;
	Mon, 22 Jul 2002 16:36:40 -0400
Date: Mon, 22 Jul 2002 22:39:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, <martin@dalecki.de>
Subject: Re: please DON'T run 2.5.27 with IDE!
Message-ID: <20020722203942.GA2917@win.tue.nl>
References: <Pine.SOL.4.30.0207222130040.27373-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0207222130040.27373-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 09:37:13PM +0200, Bartlomiej Zolnierkiewicz wrote:

> IDE 99 which is included in 2.5.27 introduced really nasty bug.
> Possible lockups and data corruption. Please do not.

On the other hand, thanks to Jens, I have been running 2.5.27 with 2.4 IDE
now for two days without any IDE-related trouble.

Andries


[usb still has some problems - hotplug is difficult;
another funny is that for me netscape 4.79 with flash works
under 2.4.17 and doesn't work under 2.5.25 or 2.5.27; have
not yet tried to trace it down; does this sound like
something well-known?]
