Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbVAEUau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbVAEUau (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVAEUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:30:49 -0500
Received: from rivendell.nexusuk.org ([84.92.27.250]:21635 "EHLO
	rivendell.nexusuk.org") by vger.kernel.org with ESMTP
	id S262650AbVAEU2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:28:50 -0500
Date: Wed, 5 Jan 2005 20:22:10 +0000 (GMT)
From: Steve Hill <steve@nexusuk.org>
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
cc: prism54-devel@prism54.org, prism54-users@prism54.org,
       Netdev <netdev@oss.sgi.com>, Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [Prism54-users] Open hardware wireless cards
In-Reply-To: <20050105200526.GL5159@ruslug.rutgers.edu>
Message-ID: <Pine.LNX.4.61.0501052017380.5818@rivendell.nexusuk.org>
References: <20050105200526.GL5159@ruslug.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 5 Jan 2005, Luis R. Rodriguez wrote:

> What I think we probably will have to do is just work torwards seeing if
> we can come up with our own open wireless hardware. I know there was
> a recent thread on lkml about an open video card -- anyone know where
> that ended up?

This may be a silly point, but there *was* good 802.11g hardware available 
which worked well with the fully open drivers.  I presume the 
manufacturers are moving to the "softmac" design instead because (for 
them) it is cheaper.  However, the point is that the working designs are 
already there and it may be that buying the existing design which is being 
phased out is cheaper for the FOSS community than developing a whole new 
open device.

Maybe it would be possible to convince one of the manufacturers that it's 
worth their while producing the older design hardware - if there is a 
single manufacturer who is making more or less the only hardware that is 
guaranteed to work under Linux there is probably quite a market for them.

  - Steve       Jabber: steve@nexusuk.org     Web: http://www.nexusuk.org/

      Servatis a periculum, servatis a maleficum - Whisper, Evanescence

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Public key available at http://www.nexusuk.org/pubkey.txt

iD8DBQFB3Ex15zUOsIV3bqERAuInAKCGVS1kzaR4En2nQnKhDPv6TptZ+QCdEzFN
y8HbDEpnxvJql8AVpDePcnA=
=NfEa
-----END PGP SIGNATURE-----
