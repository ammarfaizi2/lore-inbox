Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWGMG1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWGMG1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWGMG1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:27:35 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:62140 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S964832AbWGMG1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:27:35 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: Ulrich Drepper <drepper@redhat.com>
Date: Thu, 13 Jul 2006 16:27:13 +1000
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Jakub Jelinek <jakub@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Message-ID: <20060713062713.GC4395@cse.unsw.EDU.AU>
References: <20060712184412.2BD57180061@magilla.sf.frob.com> <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz> <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com> <44B5D77F.60200@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <44B5D77F.60200@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 12, 2006 at 10:17:51PM -0700, Ulrich Drepper wrote:
> I guess I should try to come up with a representation for this
> knowledge.

Sounds a little like the "Machine Description" as mentioned in the
UltraSPARC Virtual Machine Specification, Chapter 8

http://opensparc.sunsource.net/specs/Hypervisor-api-current-draft.pdf

-i

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEtefBWDlSU/gp6ecRArsXAJ0Ysw40iPsvcNmsbFqWjPdQUN6WYQCeOSDq
Meck6LGqXDndd6J8k9cUd/o=
=gZw1
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
