Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUJRBcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUJRBcn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 21:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUJRBcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 21:32:43 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:33437 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S268141AbUJRBck (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 21:32:40 -0400
Date: Mon, 18 Oct 2004 11:32:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Robert Love <rml@novell.com>
Cc: v13@priest.com, ttb@tentacle.dhs.org, linux-kernel@vger.kernel.org,
       gamin-list@gnome.org, viro@parcelfarce.linux.theplanet.co.uk,
       akpm@osdl.org, bkonrath@redhat.com, greg@kroah.com
Subject: Re: [RFC][PATCH] inotify 0.14
Message-Id: <20041018113237.4c4c1d11.sfr@canb.auug.org.au>
In-Reply-To: <20041018112807.3a7edbf7.sfr@canb.auug.org.au>
References: <1097808272.4009.0.camel@vertex>
	<200410180246.27654.v13@priest.com>
	<1098057129.5497.107.camel@localhost>
	<20041018112807.3a7edbf7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__18_Oct_2004_11_32_37_+1000_v+eii81w/mZUOf_/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__18_Oct_2004_11_32_37_+1000_v+eii81w/mZUOf_/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 18 Oct 2004 11:28:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au>
wrote:
>
> And you create setattr_mask_dnotify for which I can find no caller.

Similarly setattr_mask_inotify appears to have no callers (I assume it is
left over from a previous version).

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__18_Oct_2004_11_32_37_+1000_v+eii81w/mZUOf_/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBcx014CJfqux9a+8RArTwAJ9cNgEyz/R4PYmUrH+nELcJpoQFfwCfQwDq
CP4r1tZk3HnX9PIKWHGKrLg=
=XyCM
-----END PGP SIGNATURE-----

--Signature=_Mon__18_Oct_2004_11_32_37_+1000_v+eii81w/mZUOf_/--
