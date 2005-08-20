Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbVHTAkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbVHTAkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbVHTAkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:40:14 -0400
Received: from rgminet02.oracle.com ([148.87.122.31]:29078 "EHLO
	rgminet02.oracle.com") by vger.kernel.org with ESMTP
	id S965222AbVHTAkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:40:13 -0400
Date: Fri, 19 Aug 2005 17:40:11 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux clustering <linux-cluster@redhat.com>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: [PATCH 1/3] dlm: use configfs
Message-ID: <20050820004011.GF4100@insight.us.oracle.com>
Mail-Followup-To: linux clustering <linux-cluster@redhat.com>,
	David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
References: <20050818060750.GA10133@redhat.com> <20050817232218.56a06fd6.akpm@osdl.org> <20050818210747.GC22742@insight>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <20050818210747.GC22742@insight>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 18, 2005 at 02:07:47PM -0700, Joel Becker wrote:
> On Wed, Aug 17, 2005 at 11:22:18PM -0700, Andrew Morton wrote:
> > Fair enough.  This really means that the configfs patch should be split=
 out
> > of the ocfs2 megapatch...
>=20
> 	Easy to do, it's a separate commit in the ocfs2.git repository.
> Would you rather
>=20
> 	a) Do the diffs yourself (configfs commit, remaining ocfs2 commits)
> 	b) Have two repositories, configfs.git and ocfs2.git, where
> 	   ocfs2.git is configfs.git+ocfs2
> 	c) Just take the configfs patch (which really hasn't changed in
> 	   months)

	Well, I included the patch in my last email.  For the latest
spin, I've created http://oss.oracle.com/git/configfs.git.  The ocfs2
git repositories (http://oss.oracle.com/git/ocfs2-dev.git,
http://oss.oracle.com/git/ocfs2.git) are now based on the configfs one.
	If there's any other way you want me to do it, let me know.

Joel

--=20

"If the human brain were so simple we could understand it, we would
 be so simple that we could not."
	- W. A. Clouston

			http://www.jlbec.org/
			jlbec@evilplan.org

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDBnvriHQK5rbv+hERAvh5AJ9vU3wTU1TfLjxb1oFg7W4n8t31wwCeJPo0
tN1cLg/VIzXvDavb7RMy1Vc=
=V7jd
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
