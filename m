Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUIDNUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUIDNUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269916AbUIDNUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:20:25 -0400
Received: from znx208-2-156-007.znyx.com ([208.2.156.7]:14603 "EHLO
	lotus.znyx.com") by vger.kernel.org with ESMTP id S267923AbUIDNUX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:20:23 -0400
Subject: Re: [PATCH 2.6] watch64: generic variable monitoring system
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
In-Reply-To: <200409031744.32970.jeffpc@optonline.net>
References: <200409031307.01240.jeffpc@optonline.net>
	 <200409031319.24863.jeffpc@optonline.net>
	 <20040903121657.355a6a8b@dell_ss3.pdx.osdl.net>
	 <200409031744.32970.jeffpc@optonline.net>
Organization: jamalopolis
Message-Id: <1094303999.1633.116.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 04 Sep 2004 09:19:59 -0400
X-MIMETrack: Itemize by SMTP Server on Lotus/Znyx(Release 5.0.11  |July 24, 2002) at 09/04/2004
 06:21:52 AM,
	Serialize by Router on Lotus/Znyx(Release 5.0.11  |July 24, 2002) at 09/04/2004
 06:21:55 AM,
	Serialize complete at 09/04/2004 06:21:55 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a feeling this was discussed somewhere(other than netdev) and i
missed it. Why isnt this watch64 being done in user space?

cheers,
jamal

On Fri, 2004-09-03 at 17:44, Josef 'Jeff' Sipek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Friday 03 September 2004 15:16, Stephen Hemminger wrote:
> > - Code doesn't match the kernel style (read Documentation/CodingStyle)
> 
> Sorry about the white space, KMail apparently likes to butcher the text. These 
> are the same patches with the little cleanup update.
> 
> Jeff.
> 
> - -- 
> Reality is merely an illusion, albeit a very persistent one.
>   - Albert Einstein
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> 
> iD4DBQFBOOW+wFP0+seVj/4RAgSiAJj54qcqdEx66lbMW9ik0XviupTNAKC82an1
> R0pGX0pTBZ78NWrZpxJm+w==
> =EesC
> -----END PGP SIGNATURE-----

