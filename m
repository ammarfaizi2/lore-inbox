Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUBKHyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 02:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUBKHyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 02:54:13 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:50619 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263632AbUBKHyJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 02:54:09 -0500
From: tabris <tabris@tabris.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: console/gpm mouse breakage 2.6.3-rc1-mm1
Date: Wed, 11 Feb 2004 02:53:10 -0500
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200402100605.25115.tabris@tabris.net> <20040210201102.GB261@ucw.cz> <200402110024.00792.tabris@tabris.net>
In-Reply-To: <200402110024.00792.tabris@tabris.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402110253.12152.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 10 February 2004 11:50 pm, tabris wrote:
> On Tuesday 10 February 2004 3:11 pm, Vojtech Pavlik wrote:
> > On Tue, Feb 10, 2004 at 06:05:19AM -0500, tabris wrote:
>
> ok. updated... i rebuilt it, and made psmouse a module. mouse now is
> working with gpm. (tracking feels funny tho)
I think i was very unclear here. Ok. my PS/2 works now. the tracking feels 
funny tho.

My USB mouse still works as well, but still has that weird console echo 
problem, making it useless for cut&paste in console mode.
>
> also, it does NOT have the issue with the odd console echo. but my
> USB/wireless mouse still has that problem.
- --
tabris
- -
An intellectual is someone whose mind watches itself.
		-- Albert Camus
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKd9m1U5ZaPMbKQcRAu92AKCNrdMb/jIls5vQ+3nwPc6+/I0hmwCghYid
3pXd6jpjQfiQDFm1qAs9kec=
=++AZ
-----END PGP SIGNATURE-----

