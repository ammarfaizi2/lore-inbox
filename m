Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTAaPTN>; Fri, 31 Jan 2003 10:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbTAaPTN>; Fri, 31 Jan 2003 10:19:13 -0500
Received: from [81.2.122.30] ([81.2.122.30]:41736 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261371AbTAaPTM>;
	Fri, 31 Jan 2003 10:19:12 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301311527.h0VFRZrf001543@darkstar.example.net>
Subject: Re: [PATCH] 2.5.59 morse code panics
To: davej@codemonkey.org.uk (Dave Jones)
Date: Fri, 31 Jan 2003 15:27:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, szepe@pinerecords.com,
       linux-kernel@vger.kernel.org, arodland@noln.com
In-Reply-To: <20030131151224.GB15332@codemonkey.org.uk> from "Dave Jones" at Jan 31, 2003 03:12:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > A lot of newer laptops do not have serial ports.
> 
> so use something sensible like a crashdump to floppy.

A lot of newer laptops do not have floppy drives :-)

Seriously, though, I agree that morse isn't the most ideal way to get
data out of a crashed system.

>  > While morse code may
>  > be a little silly the general purpose hook  it needs to be done 
>  > cleanly is considerably more useful
> 
> sure. things like lkcd,netconsole etc could all use that
> infrastructure.   The beyond-silly bit was the 'other machine
> to decode morse' argument.

Depends on how good your morse is, I suppose, I wouldn't really want
to decode a oops from morse by ear.

>  > The exact method that a crashed machine, in a rack, in a datacentre,
>  > miles away from me, contacts me to let me know something is wrong
>  > doesn't matter, but if a member of the datacentre staff can get a
>  > detailed message to me, so much the better than just having the box
>  > rebooted.  On the other hand, I don't actually want to have to listen
>  > to ten minutes of morse code over the phone when another box could do
>  > it for me.
> 
> That must be a pretty quiet datacentre. And what happens when more than
> one box starts beeping ?

OK, point taken, that *was* a beyond-silly suggestion :-)

John.
