Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279233AbRKSPNO>; Mon, 19 Nov 2001 10:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279144AbRKSPNE>; Mon, 19 Nov 2001 10:13:04 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:16537 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278985AbRKSPM6>;
	Mon, 19 Nov 2001 10:12:58 -0500
Date: Mon, 19 Nov 2001 10:12:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <01111917034005.00817@nemo>
Message-ID: <Pine.GSO.4.21.0111191006510.17210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Nov 2001, vda wrote:

> > Trivial example: you have a directory with a bunch of subdirectories.
> > You want owners of subdirectories to see them.  You don't want them
> > to _know_ about other subdirectories.
> 
> Security through obscurity, that is.

Huh?  By the same logics /etc/shadow is security through obscurity -
after all, you can try all possible passwords one by one.  Ability to use
key != ability to see valid keys.
 
> Do you have even a single dir on your boxes with r!=x?

Yes.

Please, go to rtfm.mit.edu and find the UNIX FAQ there.  Then read the
relevant parts.

