Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129766AbRBKVt3>; Sun, 11 Feb 2001 16:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130103AbRBKVtK>; Sun, 11 Feb 2001 16:49:10 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:22800 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129766AbRBKVtI>; Sun, 11 Feb 2001 16:49:08 -0500
Message-ID: <3A870130.8A0FCBCC@namesys.com>
Date: Mon, 12 Feb 2001 00:16:32 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Adrian Phillips <a.phillips@dnmi.no>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <E14S01O-0004Su-00@the-village.bc.nu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > LADDIS is the industry standard benchmark for NFS.  It crashes for ReiserFS and
> > NFS.  We can't afford to buy it, as it is proprietary software.  Once Nikita has
> > finished testing his changes, we will ask someone to test it for us though.
> >
> 
> Do you know if the connectathon test suites show the problem?

Not the slightest idea.  Is the connectathon test suite something that stresses
the FS heavily?  If so, we can always add it to our stable, whether or not it
stresses this particular bug.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
