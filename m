Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbRBLJgJ>; Mon, 12 Feb 2001 04:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRBLJgB>; Mon, 12 Feb 2001 04:36:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56592 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129524AbRBLJfw>; Mon, 12 Feb 2001 04:35:52 -0500
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
To: reiser@namesys.com (Hans Reiser)
Date: Mon, 12 Feb 2001 09:36:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), a.phillips@dnmi.no (Adrian Phillips),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        reiserfs-list@namesys.com (reiserfs-list@namesys.com)
In-Reply-To: <3A870130.8A0FCBCC@namesys.com> from "Hans Reiser" at Feb 12, 2001 12:16:32 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SFPK-0006UY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not the slightest idea.  Is the connectathon test suite something that stresses
> the FS heavily?  If so, we can always add it to our stable, whether or not it
> stresses this particular bug.

It certainly has been stressing the NFS side of things enough to show up a lot
of problems so maybe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
