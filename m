Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135982AbRAWD4w>; Mon, 22 Jan 2001 22:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136025AbRAWD4m>; Mon, 22 Jan 2001 22:56:42 -0500
Received: from getafix.lostland.net ([216.29.29.27]:19756 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S135982AbRAWD4f>; Mon, 22 Jan 2001 22:56:35 -0500
Date: Mon, 22 Jan 2001 22:56:19 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: Mark I Manning IV <mark4@purplecoder.com>
cc: Ralf Baechle <ralf@uni-koblenz.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Coding Style
In-Reply-To: <3A6CB402.8265A7B2@purplecoder.com>
Message-ID: <Pine.BSO.4.30.0101222250360.10699-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jan 2001, Mark I Manning IV wrote:

> Ralf Baechle wrote:
> >
> > On Sun, Jan 21, 2001 at 03:00:05AM +0100, Matthias Andree wrote:
> >
> It is alot neater tho :P~
>
> // even for multi line comments
> // no visual clutter over there -->

/*
 * I tend to find standard C comments easier to read.  They stand out,
 * especially for multiple lines (although I always try to put the :end:
 * on a separate line for clarity).
 */

int function(int x)
{
	/* Bleh.  Comments take up space.
	 */
	function body;
}


Regards,
Adrian


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
