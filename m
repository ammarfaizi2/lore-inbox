Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTLNUf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTLNUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:35:26 -0500
Received: from adsl-68-248-191-228.dsl.klmzmi.ameritech.net ([68.248.191.228]:14341
	"EHLO mail.domedata.com") by vger.kernel.org with ESMTP
	id S262397AbTLNUfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:35:17 -0500
From: tabris <tabris@tabris.net>
To: coderman <coderman@charter.net>
Subject: Re: 2.4 vs 2.6
Date: Sun, 14 Dec 2003 15:23:14 -0500
User-Agent: KMail/1.5.3
References: <20031201062052.GA2022@frodo> <m2r7z8xl2o.fsf_-_@tnuctip.rychter.com> <3FDBC466.3060304@charter.net>
In-Reply-To: <3FDBC466.3060304@charter.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312141523.15209.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 13 December 2003 9:01 pm, coderman wrote:
> Jan Rychter wrote:
> >So, as for me, 2.6 is a definite no-no. I see no advantage whatsoever
> > in running it, it caused me nothing but pain, and there is no
> > improvement that I could see that would justify the upgrade.
> >
> >So please be careful when making statements like that. 2.6 is *NOT*
> >stable enough nor ready enough for people to use it, unless those
> > people have a narrow range of hardware on which the 2.6 kernel has
> > actually been tested (translation: they have the same hardware as the
> > main developers do).
>
> For every person who has problems with 2.6, there are probably 2 others
> who have none, and enjoy the benefits of the new features.  2.6 works
> great for me, and one a number of hardware configurations including:
	Somehow, working for 2/3, or even 75% of cases is less than encouraging 
to me.

	Especially if I must not only set up boxes that I may not touch 
physically for days, weeks, etc. Or I suggest which kernel for other 
people to use, due to security fixes (which, iirc, not all 2.4 fixes have 
been forward ported yet), features, etc.

	2.6 is... getting there. and I DO much appreciate the work of the 
developers. But with devfs deprecated, udev still coming into its own 
(Nice work GregKG btw); with the myriad of (user visible) input layer 
changes; the change in focus on initrds (it used to be a nice thing that 
only serious people use. Now, although still optional, it is now becoming 
much more important). Or mebbe consider that the last time I tried to 
install the new modutils (I'm blaming my distro vendor for this), it 
broke my 2.4 modutils, requiring me to boot with init=/bin/sh and fix it 
up.

Sure. little things, but altogether, they add up to a lot more work to 
learn.

<snip>
>
> 2.6 may not be usable for you, but this has no bearing on the utility
> of the branch for others.  I have noticed benefits (mainly prempt,
> IPSEC, and the IDE device handling) which make it very worthwhile.
>
- --
tabris
- -
When asked by an anthropologist what the Indians called America before
the white men came, an Indian said simply "Ours."
		-- Vine Deloria, Jr.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/3May1U5ZaPMbKQcRApmfAJ9IQexnFORYTaOEpTiyPQnHt3qCMgCeJimh
8hR+oaEqXhBXbVB9tRg9g5M=
=/Cnp
-----END PGP SIGNATURE-----

