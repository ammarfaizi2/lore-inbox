Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264106AbUEKMeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264106AbUEKMeu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbUEKMet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:34:49 -0400
Received: from ns.suse.de ([195.135.220.2]:34698 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264106AbUEKMeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:34:46 -0400
Date: Tue, 11 May 2004 14:34:41 +0200
From: Kurt Garloff <garloff@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI updates for 2.6.6
Message-ID: <20040511123441.GL4828@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1084229974.1763.512.camel@mulgrave>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A2x6GFCQWVc4i5ud"
Content-Disposition: inline
In-Reply-To: <1084229974.1763.512.camel@mulgrave>
X-Operating-System: Linux 2.6.5-9-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A2x6GFCQWVc4i5ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Mon, May 10, 2004 at 05:59:31PM -0500, James Bottomley wrote:
> This is the latest set of assorted fixes, plus one new driver: the IBM
> Power Raid (ipr).
> Kurt Garloff:
>   o scsi: don't attach device if PQ indicates not connected

Should I resubmit the other SCSI scanning/blacklist patches or are they
queued? Or rejected?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG, Nuernberg, DE                          SUSE Labs (Head)

--A2x6GFCQWVc4i5ud
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoMhhxmLh6hyYd04RAuETAJ48exSUifdwAgNrNvkGh9fsACMefgCfSCTI
GQAQ3OdfYt64DPj7ORF9GmA=
=ve1i
-----END PGP SIGNATURE-----

--A2x6GFCQWVc4i5ud--
