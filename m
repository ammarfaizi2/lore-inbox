Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVG2GP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVG2GP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 02:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVG2GP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 02:15:26 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:47773 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S262445AbVG2GPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 02:15:20 -0400
Date: Fri, 29 Jul 2005 02:15:18 -0400
From: Yaroslav Halchenko <yoh@psychology.rutgers.edu>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.8 -> 2.6.11 (+ata-dev patch) -- HDD is always on
Message-ID: <20050729061518.GB6655@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Jeff Garzik <jgarzik@pobox.com>
References: <20050729041031.GU16285@washoe.onerussian.com> <42E9AFC6.9010805@pobox.com> <20050729055820.GX16285@washoe.onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729055820.GX16285@washoe.onerussian.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damn me - sorry for the misinformation... I've compiled the kernel
without Debian-loved initrd image... 

so I've booted 2.6.12.3 -- LED light is on - so I bet no blame on libata
patch, although I've mentioned few patches from that patch migrated into
the mainstream kernel.   

Any ideas on which next step to take? 2.6.13-rc4? or vanilla 2.6.11?


On Fri, Jul 29, 2005 at 01:58:20AM -0400, Yaroslav Halchenko wrote:
> On Fri, Jul 29, 2005 at 12:25:42AM -0400, Jeff Garzik wrote:
> > Does this happen in unpatched 2.6.12.3 or 2.6.13-rc4?
> just tried unpatched 2.6.12.3.
> The Box stalls booting with 
> "Uncompressing Linux... Ok, booting the kernel.
> _"

> interesting though that led hdd light is off at first, blinks few
> times, and 1-2 secs after it stalls with above message - it gets its
> steady green light on.

> Could I screw up some NEW kernel configuration parameters when pulling
> config from 2.6.8 from Debian? I don't know :-/

> I will try 2.6.13-rc4 now... heh heh
-- 
Yaroslav Halchenko
Research Assistant, Psychology Department, Rutgers-Newark
Office: (973) 353-5440x263 | FWD: 82823 | Fax: (973) 353-1171
        101 Warren Str, Smith Hall, Rm 4-105, Newark NJ 07105
Student  Ph.D. @ CS Dept. NJIT
