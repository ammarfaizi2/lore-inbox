Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269853AbUIDJiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269853AbUIDJiV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269854AbUIDJiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:38:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49104 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269853AbUIDJiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:38:09 -0400
Date: Sat, 4 Sep 2004 11:37:45 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: torvalds@osdl.org, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dcn@sgi.com
Subject: Re: [IA64] allow OEM written modules to make calls to ia64 OEM SAL functions.
Message-ID: <20040904093745.GB5313@devserv.devel.redhat.com>
References: <200409032207.i83M7CKj015068@hera.kernel.org> <1094280707.2801.0.camel@laptop.fenrus.com> <20040904103529.C13149@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <20040904103529.C13149@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 04, 2004 at 10:35:29AM +0100, Christoph Hellwig wrote:
> On Sat, Sep 04, 2004 at 08:51:47AM +0200, Arjan van de Ven wrote:
> > On Wed, 2004-08-25 at 20:27, Linux Kernel Mailing List wrote:
> > > ChangeSet 1.1803.128.1, 2004/08/25 18:27:33+00:00, dcn@sgi.com
> > > 
> > > 	[IA64] allow OEM written modules to make calls to ia64 OEM SAL functions.
> > > 	
> > > 	Add wrapper functions for SAL_CALL(), SAL_CALL_NOLOCK(), and
> > > 	SAL_CALL_REENTRANT() that allow OEM written modules to make
> > > 	calls to ia64 OEM SAL functions.
> > > 	
> > 
> > are there any such modules? Are they GPL licensed or all proprietary ?
> 
> SGI has stated they have propritary modules that need this, that's why it's
> got added despite my objections.

if there are no open source modules that use these exports I would like to
ask these exports to be undone again..
--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBOYzoxULwo51rQBIRAo6hAJ4ilPpLuSNV1l90m7Ny8qS/kdGM+ACghc4u
2KTv4teNQtvjVVYOmN+QWJ4=
=ydbT
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
