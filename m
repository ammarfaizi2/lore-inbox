Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVBRAdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVBRAdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 19:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBRAdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 19:33:31 -0500
Received: from nabe.tequila.jp ([211.14.136.221]:10967 "HELO nabe.tequila.jp")
	by vger.kernel.org with SMTP id S261252AbVBRAcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 19:32:39 -0500
Message-ID: <4215379D.7080708@tequila.co.jp>
Date: Fri, 18 Feb 2005 09:32:29 +0900
From: Clemens Schwaighofer <cs@tequila.co.jp>
Organization: TEQUILA\Japan
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041220 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sean <seanlkml@sympatico.ca>
CC: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>,
       Olivier Galibert <galibert@pobox.com>, kernel@crazytrain.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK] upgrade will be needed
References: <20050214020802.GA3047@bitmover.com>    <58cb370e05021404081e53f458@mail.gmail.com>    <20050214150820.GA21961@optonline.net>    <20050214154015.GA8075@bitmover.com>    <7579f7fb0502141017f5738d1@mail.gmail.com>    <20050214185624.GA16029@bitmover.com>    <1108469967.3862.21.camel@crazytrain> <42131637.2070801@tequila.co.jp>    <20050216154321.GB34621@dspnet.fr.eu.org>    <4213E141.5040407@tequila.co.jp>    <e9d587a22ff0b23ccbb6fa112377dbee@e18.physik.tu-muenchen.de>    <42145128.4030202@tequila.co.jp>    <e030fd01c5625a80b90382e69843213f@e18.physik.tu-muenchen.de> <4428.10.10.10.24.1108636051.squirrel@linux1>
In-Reply-To: <4428.10.10.10.24.1108636051.squirrel@linux1>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/17/2005 07:27 PM, Sean wrote:
> On Thu, February 17, 2005 4:27 am, Roland Kuhn said:
> 
> 
>>The difference comes after the merge. Suppose Andrew didn't push
>>everything to Linus. Then new patches come in, both trees change. In
>>this situation it is very time consuming with subversion to work out
>>the changes which still have to go from Andrew's tree to Linus' tree.
> 
> 
> Since Andrew does this all by hand now, subversion / arch / whatever could
> only improve the situation.  And the kicker is that using a free system
> would mean the result could be dumped into BK for those that want to use
> it.   The reverse unfortunately isn't true; not because of technical
> reasons, but because of license restrictions.

well I think Andrew will have tonsof small helper scripts for that. I
doubt he has time to try out various vcs ... (especially if they are so
complicated to use like arch).

- --
[ Clemens Schwaighofer                      -----=====:::::~ ]
[ TBWA\ && TEQUILA\ Japan IT Group                           ]
[                6-17-2 Ginza Chuo-ku, Tokyo 104-0061, JAPAN ]
[ Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343 ]
[ http://www.tequila.co.jp        http://www.tbwajapan.co.jp ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCFTecjBz/yQjBxz8RAqx5AJ9TCxTpvXkfnUbGiPM67VQsa5RVlwCeMXPR
9RPlx/090x7ALlctuvSnWo4=
=9Xst
-----END PGP SIGNATURE-----
