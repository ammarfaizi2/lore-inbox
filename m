Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXWwZ>; Wed, 24 Jan 2001 17:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132971AbRAXWwP>; Wed, 24 Jan 2001 17:52:15 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:64262 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S129401AbRAXWwG>;
	Wed, 24 Jan 2001 17:52:06 -0500
Date: Wed, 24 Jan 2001 14:51:40 -0800
From: alex@foogod.com
To: Mark Smith <mark@winksmith.com>
Cc: Steven Ellmore <steve@signalstorm.com>,
        Steve Underwood <steveu@coppice.org>, linux-kernel@vger.kernel.org
Subject: Re: Probably Off-topic Question...
Message-ID: <20010124145140.N2452@draco.foogod.com>
In-Reply-To: <Pine.LNX.4.10.10101222129310.3031-100000@clueserver.org> <3A6F0D6B.34EB2CB0@coppice.org> <20010124123001.52317@winksmith.com> <3A6F2F9E.6030600@signalstorm.com> <20010124173854.35773@winksmith.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010124173854.35773@winksmith.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 05:38:54PM -0500, Mark Smith wrote:
> On Wed, Jan 24, 2001 at 07:40:14PM +0000, Steven Ellmore wrote:
> > My VAIO Z505HS brightness control works under Linux.
> > 
> > Shift + Fn + Brightness (F5) dims
> > Fn + Brightness brightens
[...]
> none of these things change my brightness one way or the other.
> in particular, which part of the OS would be responsible for
> watching these keystrokes and making the appropriate changes?

With the Z505H/J series, this is handled entirely by the BIOS and the OS has 
no part of it.  I'm not sure about the L's, but they're otherwise fairly 
similar to the H/J's.  (I have absolutely no idea about other lines like the 
picturebooks, of course, as the different lines from Sony are effectively 
completely unrelated.)

> others have told me about this keystroke.  someone had suggested
> that this works differently on my system because i have a newer
> bios?

This is possible.  I don't know why they would change this, unless it was some 
requirement of propertly integrating the newer Windows versions, which is 
possible.  In this case, my guess is that it's probably exposed via ACPI or 
something similar.  Any ACPI folks got thoughts on this as a possibility (and 
how one might find out)?  I have to admit I haven't played with it much.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
