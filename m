Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbRDJLQz>; Tue, 10 Apr 2001 07:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRDJLQq>; Tue, 10 Apr 2001 07:16:46 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:62329 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131424AbRDJLQ3>; Tue, 10 Apr 2001 07:16:29 -0400
Date: Tue, 10 Apr 2001 12:16:22 +0100
From: Tim Waugh <twaugh@redhat.com>
To: kees <kees@schoen.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] exec_via_sudo
Message-ID: <20010410121622.H1136@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0104101251210.6726-100000@schoen3.schoen.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jPJw4wSVUvI9Tm/b"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104101251210.6726-100000@schoen3.schoen.nl>; from kees@schoen.nl on Tue, Apr 10, 2001 at 12:55:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jPJw4wSVUvI9Tm/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 10, 2001 at 12:55:29PM +0200, kees wrote:

> Unix/Linux have a lot of daemons that have to run as root because they
> need to acces some specific data or run special programs. They are
> vulnerable as we learn.
> Is there any way to have something like an exec call that is
> subject to a sudo like permission system? That would run the daemons
> as a normal user but allow only for specific functions i.e. NOT A SHELL.

Yeah, exec sudo.

Tim.
*/

--jPJw4wSVUvI9Tm/b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE60uuGONXnILZ4yVIRAht9AKCHLasBvP1BxvPCXsJC+NS2HVbTpgCfY2cY
fK5ZiDfRL9lkGuFiWhCQfJQ=
=d/fm
-----END PGP SIGNATURE-----

--jPJw4wSVUvI9Tm/b--
