Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVCJR1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVCJR1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbVCJR1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:27:10 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:21394 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262731AbVCJRTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:19:25 -0500
Message-ID: <423081AB.5030506@comcast.net>
Date: Thu, 10 Mar 2005 12:19:39 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: binary drivers and development
References: <423075B7.5080004@comcast.net> <20050310164847.GA16430@kroah.com>
In-Reply-To: <20050310164847.GA16430@kroah.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Greg KH wrote:
> On Thu, Mar 10, 2005 at 11:28:39AM -0500, John Richard Moser wrote:
> 
>>I've been looking at the UDI project[1] and thinking about binary
>>drivers and the like, and wondering what most peoples' take on these are
>>and what impact that UDI support would have on the kernel's development.
> 
> 
> Please, the UDI stuff has been proven to be broken and wrong.  If you
> want to work on it, feel free to do so, just don't expect for anyone to
> accept the UDI layer into the kernel mainline.
> 

1.  What's broken about it
2.  Is it possible to fix it

I require information or else I can't assess things.

> What's that phrase about people forgetting history are doomed...
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCMIGqhDd4aOud5P8RAl+PAJ4ndKTmqyRRc+qaJjPK62HBABb0rgCgjCTR
8kQ9MOOdZiH3FUsNG1Hoe3E=
=NIcs
-----END PGP SIGNATURE-----
