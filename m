Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269364AbUI3Sc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269364AbUI3Sc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUI3ScZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:32:25 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:31398 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S269364AbUI3ScI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:32:08 -0400
Date: Thu, 30 Sep 2004 12:32:00 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Stephen Tweedie <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, ext2-devel@lists.sourceforge.net
Subject: Re: [Patch 0/10]: Cleanup online reservations for 2.6.9-rc2-mm4.
Message-ID: <20040930183200.GR2061@schnapps.adilger.int>
Mail-Followup-To: Stephen Tweedie <sct@redhat.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Theodore Ts'o <tytso@mit.edu>, ext2-devel@lists.sourceforge.net
References: <200409301323.i8UDNAR3004753@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tcb1KvpfnM4LxW2s"
Content-Disposition: inline
In-Reply-To: <200409301323.i8UDNAR3004753@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Tcb1KvpfnM4LxW2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 30, 2004  14:23 +0100, Stephen Tweedie wrote:
> The patches to follow clean up a lot of the ext3 online reservation
> code in 2.6.9-rc2-mm4.  There are a few minor fixes for things like
> loglevels of printks and correcting some error returns, plus
> refactoring a bit of existing ext3 code to allow resize to avoid dummy
> on-stack inodes.=20

Many thanks to Stephen for putting in the effort to bring this into
shape.  All of the patches look good.

Cheers, Andreas
--
Andreas Dilger
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--Tcb1KvpfnM4LxW2s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBXFEgpIg59Q01vtYRAniOAJ9FvKsO9dR/tESvMgiqsgphjxkJuQCfXoEW
NSJ1jeZ39p1OWQVPu3lkcYU=
=Loo/
-----END PGP SIGNATURE-----

--Tcb1KvpfnM4LxW2s--
