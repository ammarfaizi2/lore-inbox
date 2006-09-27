Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965420AbWI0Hnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965420AbWI0Hnz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965433AbWI0Hnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:43:55 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:14557 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965420AbWI0Hny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:43:54 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: x86/x86-64 merge for 2.6.19
Date: Wed, 27 Sep 2006 09:44:34 +0200
User-Agent: KMail/1.9.4
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
References: <200609261244.43863.ak@suse.de> <4d8e3fd30609261425ob262489nec1240f5a0c5050f@mail.gmail.com> <Pine.LNX.4.64.0609261439220.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609261439220.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1402724.siy7PaY2Bz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609270944.35110.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1402724.siy7PaY2Bz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 26. September 2006 23:43 schrieb Linus Torvalds:
> On Tue, 26 Sep 2006, Paolo Ciarrocchi wrote:
> > out of curiosity, wouldn't be better to sync with Andrew via git?
> > Why via plain patches?
> >
> > What am I missing?
>
> I think you're just missing that we've become so used to it that it's just
> easier than all the alternatives.

[...]

> I think it's worked out pretty well, no?

Nearly everyone else seems to remove the '[PATCH]' from the subject line wh=
en=20
putting things into git. Everything I suspect coming from Andrew to your tr=
ee=20
still has it. Is this intentional or just yet another skript needing a=20
fix? :)

Eike

--nextPart1402724.siy7PaY2Bz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFGivjXKSJPmm5/E4RAq3qAJ41RcD8pZ71Up0QyczJ+Rwty67a5ACeIENf
NiARQBZTyfVnEkzZWcBYJdA=
=7xe/
-----END PGP SIGNATURE-----

--nextPart1402724.siy7PaY2Bz--
