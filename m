Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313731AbSDUSXW>; Sun, 21 Apr 2002 14:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313724AbSDUSVv>; Sun, 21 Apr 2002 14:21:51 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:37285 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313719AbSDUSUc>;
	Sun, 21 Apr 2002 14:20:32 -0400
Date: Sun, 21 Apr 2002 14:20:30 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Larry McVoy <lm@work.bitmover.com>, CaT <cat@zip.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421142030.F8142@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <E16yz02-0000lC-00@starship> <20020421175404.GL4640@zip.com.au> <20020421111134.O10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 11:11:34AM -0700, Larry McVoy wrote:
> If that is correct, then what we really want is email when something
> lands on bkbits.net and is not yet included in Linus' tree.  We can
> certainly set up a trigger to send email in that case.

Can you be convinced to post a sample trigger doing this?

Not only will that show people an example of emailing from a trigger,
but more importantly it will expose any wonky details of the bkbits.net
email system that need to be accounted for...  Does standard pipe to
/usr/sbin/sendmail -t -i work as expected, for example?

	Jeff



