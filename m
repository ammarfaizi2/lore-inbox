Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUHOBXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUHOBXT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 21:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUHOBXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 21:23:19 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:30438 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266296AbUHOBXR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 21:23:17 -0400
From: Andy Stewart <andystewart@comcast.net>
Reply-To: andystewart@comcast.net
Organization: Worcester Linux Users' Group
To: Greg KH <greg@kroah.com>
Subject: Re: USB kernel oops 2.6.7
Date: Sat, 14 Aug 2004 21:16:17 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408131947.55873.andystewart@comcast.net> <20040814055057.GE6838@kroah.com>
In-Reply-To: <20040814055057.GE6838@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408142120.38347.andystewart@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 14 August 2004 1:50 am, Greg KH wrote:
> On Fri, Aug 13, 2004 at 07:47:45PM -0400, Andy Stewart wrote:
> > HI everybody,
> >
> > When I unplugged my Kodak DC4800 USB camera, I noticed this kernel
> > problem in /var/log/messages.  I'm running a stock 2.6.7 kernel compiled
> > for SMP.
>
> Can you try 2.6.8-rc4 to see if this is fixed there or not?
>
> And did you unmount the camera after mounting it, before removing the
> device?
>
> thanks,
>
> greg k-h

HI Greg,

I tried the 2.6.8 kernel and my USB camera is working much better - perfectly, 
in fact! 

Thank you very much!

Andy

- -- 
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA  USA
http://www.wlug.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBHrlqHl0iXDssISsRAjifAJ4mP94E8M53cS+cW+Jv75NRgUFpsgCeNJZe
mSgJFwWf6VotZn9Art3/nP8=
=kfH1
-----END PGP SIGNATURE-----
