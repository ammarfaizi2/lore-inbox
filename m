Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTKNW4W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 17:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTKNW4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 17:56:22 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:25863 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262522AbTKNW4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 17:56:21 -0500
Date: Fri, 14 Nov 2003 23:55:55 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Tupshin Harper <tupshin@tupshin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <Pine.GSO.4.21.0311141051440.2853-100000@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.44.0311142049560.4492-100000@serv>
References: <Pine.GSO.4.21.0311141051440.2853-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Nov 2003, Geert Uytterhoeven wrote:

> So if all individual mails were archived somewhere with correct sequence
> numbers, they could be used to recreate the whole repository in whatever format
> you want. I guess it's just a matter of importing them like patches into arch.

The problematic part are "correct sequence numbers" here. These numbers in 
the commit list mails are pretty much useless. At least the numbers in 
this line:

#                  ChangeSet    1.1437+1.1350.5.10 -> 1.1438

have to be replaced with a unique identifier. This identifier does exist, 
e.g. it's visible in the exclude mails.
As soon as someone finds out how to export changesets in this format and 
stores them somewhere, other people can make use of this data. 
Unfortunately it's rather unlikely that anyone who can do the first, knows 
also how to do the latter (but maybe Larry can tell us the trick).
Anyway, if someone has this data I'd be interested in a copy.

bye, Roman

