Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSBYRp5>; Mon, 25 Feb 2002 12:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSBYRpt>; Mon, 25 Feb 2002 12:45:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15810 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288980AbSBYRpa>;
	Mon, 25 Feb 2002 12:45:30 -0500
Date: Mon, 25 Feb 2002 12:45:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] Son of Unbork (1 of 3)
In-Reply-To: <E16fPNj-0005fa-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0202251244040.3162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Alan Cox wrote:

> > > will come once more to Middle-Earth.  (I made that last part up.)
> > > 
> > > Patch 1 adds alloc_super and destroy_super methods to struct file_system.  A 
> > 
> > Vetoed.
> 
> Al your mailer appears to have cut off the second paragraph, the one which
> I assume started with "Because ..."

Basically, "because they don't give anything that couldn't be easily done
without them".  See another posting for more details.

