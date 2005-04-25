Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbVDYCVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbVDYCVM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 22:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVDYCVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 22:21:12 -0400
Received: from pop.gmx.de ([213.165.64.20]:7115 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262451AbVDYCVG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 22:21:06 -0400
X-Authenticated: #590723
From: Fabian Franz <FabianFranz@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>,
       "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Git-commits mailing list feed.
Date: Mon, 25 Apr 2005 04:17:13 +0200
User-Agent: KMail/1.5.4
Cc: Paul Jakma <paul@clubi.ie>, Sean <seanlkml@sympatico.ca>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <426C4168.6030008@dwheeler.com> <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504241846290.18901@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200504250417.17231.FabianFranz@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 25. April 2005 03:50 schrieb Linus Torvalds:

> Maybe we'll just have signed tags by doing exactly that: just a collection
> of detached signature files. The question becomes one of how to name such
> things in a distributed tree. That is the thing that using an object for
> them would have solved very naturally.

What about just <sha1 hash of object>.sig or <sha1 hash of object>.asc?

Or would this violate the concept of the object database to just contain 
hashes?

cu

Fabian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCbFMsI0lSH7CXz7MRAof0AKCILjPE/M72cMSVNDC/DWYSzmrU/ACggOuS
ogNPwUf2ASAwmbwixzSTuPs=
=pW5D
-----END PGP SIGNATURE-----

