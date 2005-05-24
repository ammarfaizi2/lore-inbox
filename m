Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVEXAqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVEXAqJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVEXAqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:46:08 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:3999 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261267AbVEXAol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:44:41 -0400
Message-ID: <429278F7.70008@comcast.net>
Date: Mon, 23 May 2005 20:44:39 -0400
From: Andy Stewart <andystewart@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: enable-reads-on-plextor-712-sa-on-26115.patch added to -mm tree
References: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net>	<4292628E.4090209@pobox.com>	<4292743C.4040409@comcast.net> <20050523173420.22281325.akpm@osdl.org>
In-Reply-To: <20050523173420.22281325.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


HI Andrew,

Andrew Morton wrote:
> Andy Stewart <andystewart@comcast.net> wrote:
>>>Good show.
>>Aw, come on, Jeff.  I gave it a shot,
> 
> You did, and that's very much appreciated, thanks.

Thank you for the encouraging words.  :-)

> 
>>If you believe this patch is
>>inappropriate, then please ask Andrew Morton to remove it
> 
> I already have removed it, but only because it appears that the patch might
> cause regressions in other areas.

I agree that my patch should be removed if it is breaking other things.
Thanks for taking it out.

> 
> Basically it goes like this:
> 
> - Someone sends a patch
> 
> - Patch gets ignored.
> 
> - I merge it, without even looking at the thing.
> 
> I do this as a reminder to myself and to other developers that there is
> some kernel bug or shortcoming.  Basically, it's a bug-tracking system. 
> Periodically I'll spam the maintainer with the patch and eventually he'll
> tell me to drop the thing because the problem is fixed, or he'll tell the
> originator why the patch will never be merged.
> 
> Either way, the patch (and the problem which caused you to write the patch)
> gets some sort of definite dispositive handling, rather than falling
> through a crack.

Thank you for the explaination, and for the feedback to let me know that
the patch didn't fall through the cracks.

Andy

- --
Andy Stewart, Founder
Worcester Linux Users' Group
Worcester, MA, USA
http://www.wlug.org

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCknj3Hl0iXDssISsRApp1AJ97vyP5CGavkNmP0TIHL4yvVga6nwCdFL1+
wYN6ergAnBeboO0OQK9/NBo=
=RwPj
-----END PGP SIGNATURE-----
