Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTAMNGi>; Mon, 13 Jan 2003 08:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbTAMNGh>; Mon, 13 Jan 2003 08:06:37 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:16013 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267322AbTAMNGf>;
	Mon, 13 Jan 2003 08:06:35 -0500
Date: Mon, 13 Jan 2003 13:12:42 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hubert Mantel <mantel@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UnitedLinux violating GPL?
Message-ID: <20030113131242.GF9031@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Hubert Mantel <mantel@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301111634.h0BGYGUt003680@eeyore.valparaiso.cl> <10213.1042313279@passion.cambridge.redhat.com> <20030112131535.GA8594@suse.de> <1042390241.15051.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042390241.15051.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 04:50:43PM +0000, Alan Cox wrote:

 > > So you are saying that Alan Cox is violating the GPL since he releases his 
 > > -ac kernels only as one single monolithic patch against the vanilla tree, 
 > > not as individual patches (like Andrea Arcangeli does for example)?
 > > I think the motivation for this ridiculous thread is very obvious.
 > 
 > I think Dave needs to type "man diff" 8)

I think Dave needs a diff that allows me to keep as many patches
in sync as bk lets me.  We don't all have your superhuman
patch-fu Alan 8-)

I do periodic GNU diffs of the 'big bundle o' patches'.
There are even split up versions of the patches.
All there to see at k.o
The merges Ive done with bitkeeper to Linus recently
have been diffs already posted to the 2.4 commit list.
Asides from the AGP bits, which were 99% already posted
to linux-kernel. The remainder were trivial things, and they
showed up in -bk an hour or so later anyways..

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
