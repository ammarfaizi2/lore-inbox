Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276110AbRI1PJs>; Fri, 28 Sep 2001 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276109AbRI1PJj>; Fri, 28 Sep 2001 11:09:39 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:54686 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S276108AbRI1PJ2>; Fri, 28 Sep 2001 11:09:28 -0400
Date: Fri, 28 Sep 2001 16:09:55 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Nikita Danilov <Nikita@Namesys.COM>
cc: <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: weirdness in reiserfs
In-Reply-To: <15284.36676.918419.684442@beta.reiserfs.com>
Message-ID: <Pine.LNX.4.33.0109281608510.10065-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:55 +0400 Nikita Danilov wrote:

> > I have a 240GB reiserfs ataraid partition on one of my servers (2.4.9-ac10
[snip]
> > I deleted a tarball of one of my directories; I forget how big the file
[snip]
> > is bigger than the journal size or something. But.. the partition was
> > otherwise inaccessible with processes just blocking. Oddly df worked
> > though, so I could watch my use of the filesystem going down!
>
>Were there reiserfs-related messages in the kernel log?

No.. nothing to go on :-/

