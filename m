Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUHBTyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUHBTyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUHBTyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:54:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29359 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262768AbUHBTyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:54:18 -0400
Date: Mon, 2 Aug 2004 21:53:31 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Robert White <rwhite@casabyte.com>
Cc: "'David S. Miller'" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: tcp_push_pending_frames() without TCP_CORK or TCP_NODELAY
Message-ID: <20040802195330.GA23939@devserv.devel.redhat.com>
References: <20040801195411.0577b7f2.davem@redhat.com> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAbqjYSy59TU+ukzdi1lcNqgEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAbqjYSy59TU+ukzdi1lcNqgEAAAAA@casabyte.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 02, 2004 at 12:44:41PM -0700, Robert White wrote:
> Is there an argument _against_ providing an explicit flush?

well MSG_MORE is equivalent, it's an explicit non-flush... 


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBDpu5xULwo51rQBIRAhs7AJ40XXvP37DvLaTO9ebEz7JXGM3GewCgoDqo
0nF2mcUNm+rWU3OXyGM1NS0=
=l3ez
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
