Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbTCZF7N>; Wed, 26 Mar 2003 00:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbTCZF7N>; Wed, 26 Mar 2003 00:59:13 -0500
Received: from mta05ps.bigpond.com ([144.135.25.137]:7380 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S261293AbTCZF7M>; Wed, 26 Mar 2003 00:59:12 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Eric Wong <eric@yhbt.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [PATCH] Logitech USB mice/trackball extensions
Date: Wed, 26 Mar 2003 16:54:08 +1100
User-Agent: KMail/1.4.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20030326022938.GA5187@bl4st.yhbt.net> <20030326034841.GA20858@kroah.com> <20030326040946.GB13242@BL4ST>
In-Reply-To: <20030326040946.GB13242@BL4ST>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200303261654.08896.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 26 Mar 2003 15:09, Eric Wong wrote:
> Greg KH <greg@kroah.com> wrote:
> > On Tue, Mar 25, 2003 at 07:03:30PM -0800, Eric Wong wrote:
> > > Oops, ignore this part, it's part of a separate patch :)
> >
> > Can you send me an updated patch?
Doing it in kernel space with module options is gross. This is clearly a case 
for userspace.

See: http://www.linmagau.org/modules.php?name=Sections&op=viewarticle&artid=40

Brad

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+gUCAW6pHgIdAuOMRAq3GAKCOMCH9x+n9pIiezYfy1wkubYW7/gCeIY6O
b9/lNmg7lOOEsG6EQhbW3KY=
=1q8A
-----END PGP SIGNATURE-----

