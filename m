Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTFUC0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 22:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbTFUC0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 22:26:20 -0400
Received: from main.gmane.org ([80.91.224.249]:55937 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265069AbTFUC0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 22:26:19 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Date: Fri, 20 Jun 2003 19:18:26 -0700
Message-ID: <m2ptl8cgwd.fsf@tnuctip.rychter.com>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de>
 <20030620101452.GA2233@ghanima.endorphin.org>
 <20030620102455.GC26678@wotan.suse.de>
 <20030620103538.GA28711@wohnheim.fh-wedel.de>
 <20030620105120.GA2450@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Portable Code, linux)
X-Spammers-Please: blackholeme@rychter.com
Cancel-Lock: sha1:1neL5Fxg9Ulwa65UnP+LXl7rrsg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Fruhwirth Clemens <clemens@endorphin.org> writes:
> On Fri, Jun 20, 2003 at 12:35:38PM +0200, J=F6rn Engel wrote:
[...]
> > If we can avoid the pain completely, use that better fix instead,
> > even if it isn't ready before 2.7, and ignore the problem until
> > then.
> No please, I don't wanna patch my kernel for another 2
> years. Andrew Morton is right when he puts this issue on his
> must-fix list.

FWIW, I've been patching my kernels for who knows how long now with this
fix. And I know other people who have been doing the same.

Clemens is right, it's really needed.

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+88B6Lth4/7/QhDoRAtVPAKCwHys4aovzYnbTnEe/ZkltgOKbSQCeKzW3
78iZXv6Uu0N9uMz83DmV9hg=
=e+tD
-----END PGP SIGNATURE-----
--=-=-=--

