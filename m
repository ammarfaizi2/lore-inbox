Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271807AbTGXWyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 18:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271808AbTGXWyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 18:54:35 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:16134 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S271807AbTGXWyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 18:54:33 -0400
Date: Thu, 24 Jul 2003 16:09:29 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: Ben Collins <bcollins@debian.org>
Cc: gaxt <gaxt@rogers.com>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Firewire
Message-ID: <20030724230928.GB23196@ruvolo.net>
Mail-Followup-To: Ben Collins <bcollins@debian.org>, gaxt <gaxt@rogers.com>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <3F1FE06A.5030305@rogers.com> <20030724223522.GA23196@ruvolo.net> <20030724223615.GN1512@phunnypharm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <20030724223615.GN1512@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2003 at 06:36:15PM -0400, Ben Collins wrote:
> I know damn well that 2.6.0-test1 is not running r578 of the ohci1394
> driver. In fact, that's 10 months old.

Er.. whoops.  Sorry, that was from my 2.4 boot.  Here's the right one.  This
is at module load time.  The rest of the data is correct.

-Chris


ohci1394: $Rev: 986 $ Ben Collins <bcollins@debian.org>                    =
    =20
PCI: Found IRQ 10 for device 0000:00:0b.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=3D[10]  MMIO=3D[db001000-db0017ff]  Ma=
x Packet=3D[2048]
raw1394: /dev/raw1394 device initialized
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00160 ffc00000 00000000 60f30404                    =
    =20
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00560 ffc00000 00000000 60f30404
ieee1394: unsolicited response packet received - np
ieee1394: contents: ffc00960 ffc00000 00000000 60f30404
ieee1394: ConfigROM quadlet transaction error for node 00:1023


--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/IGcoKO6EG1hc77ERAv4uAKD/Zg7xoQcoFLAoyKINNdA/4OQj3gCdHG3u
9sw5AGkATQHvkhqZ7vxepJU=
=d6Cz
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
