Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBGWOI>; Wed, 7 Feb 2001 17:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129997AbRBGWN7>; Wed, 7 Feb 2001 17:13:59 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:48398 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129053AbRBGWNl>; Wed, 7 Feb 2001 17:13:41 -0500
Date: Wed, 07 Feb 2001 17:13:06 -0500
From: Chris Mason <mason@suse.com>
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>
cc: Chris Wedgwood <cw@f00f.org>, David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
Message-ID: <713040000.981583986@tiny>
In-Reply-To: <3A81C6BF.D892CFE6@baldauf.org>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, February 07, 2001 11:05:51 PM +0100 Xuan Baldauf
<xuan--reiserfs@baldauf.org> wrote:

> Mhhh. It's a busy server from which I am about 700km away. I don't like to
> restart it now. (Especially because it cannot boot from hard disk, only
> from floppy disk, due to bios problems). But I'd be happy if following is
> true:
> 
> (1) Enabling "-o notails" is possible at runtime, i.e. "mount / -o
> remount,notails" works and

Nope.

> (2) Notails is compatible with all the tails found on disk (so notails
> only changes the way the disk is written, not the way the disk is read).
> 

This part is true.

Honestly, I don't want to do this kind of debugging on a busy server.
Sure, it is completely safe, etc, etc, but ...

We'll get the info elsewhere, leave the busy servers out of it ;-)

-chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
