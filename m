Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261820AbTCLRpL>; Wed, 12 Mar 2003 12:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261821AbTCLRpL>; Wed, 12 Mar 2003 12:45:11 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:30213 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261820AbTCLRpK>; Wed, 12 Mar 2003 12:45:10 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303121757.h2CHveVF001517@81-2-122-30.bradfords.org.uk>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 12 Mar 2003 17:57:40 +0000 (GMT)
Cc: dana.lacoste@peregrine.com, linux-kernel@vger.kernel.org, lm@bitmover.com
In-Reply-To: <3E6F6E84.1010601@zytor.com> from "H. Peter Anvin" at Mar 12, 2003 09:29:40 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This sounds like the old GPL argument.
> > 
> > The GPL'd redistributor has to supply the source, they don't have to
> > supply it in the format that's best for you, being an 80mm tape drive
> > cuz you're stuck in the punch card age.
> > 
> > Seriously, if CVS loses all that data, is that BK's fault?  BK's so
> > powerful because it has more information than anyone else, but it's
> > not their fault (and it's not proprietary data) that no-one else can
> > deal with the data when it's exported, now is it????
> > 
> > It's not a significant data loss when you try to view a 24bpp image
> > on an 8bpp display, so it's not a significant data loss that CVS can't
> > handle the BK.  If it could, Linus would've switched to CVS instead....
> > 
> 
> You're missing the point completely.
> 
> Of course it's not BK's fault that CVS can't represent the data. 
> However, one of the (valid!) selling points of BK was "we won't hold 
> your data hostage."  That requires that you can export both the data and 
> the metadata into some kind of open format.  Since CVS clearly can't be 
> that open format (CVS being insufficiently powerful), the additional 
> metadata needs to be available in some kind of auxilliary form.  It's 
> then, of course, not BK's fault that CVS can't possibly make use of that 
> auxilliary metadata.

I thought that BK has been able to export everything to a text file
since the first version.

(Ah, but of course, unless that text file is available in EBCDIC, we
still have a problem...)

John.
