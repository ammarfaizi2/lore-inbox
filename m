Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTJ0SJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263457AbTJ0SJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 13:09:13 -0500
Received: from smtp800.mail.ukl.yahoo.com ([217.12.12.142]:18325 "HELO
	smtp800.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263448AbTJ0SI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 13:08:58 -0500
From: Bob Johnson <livewire@gentoo.org>
Reply-To: livewire@gentoo.org
To: Shaun Savage <savages@savages.net>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, edt@aei.ca, nuno.silva@vgertech.com
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
Date: Mon, 27 Oct 2003 13:08:46 -0500
User-Agent: KMail/1.5.4
References: <3F9D402F.9050509@savages.net>
In-Reply-To: <3F9D402F.9050509@savages.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310271308.53135.livewire@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The Sata driver worked well on my siimage, but lost around 30%-40% performance
according to tiobench.

			Bob

On Monday 27 October 2003 10:56 am, Shaun Savage wrote:
>  >Are you using CONFIG_SCSI_SATA in 2.6?
>
> No, but I am trying now.
> GREAT is works,
> but the disk went from hda back to hde
>
>  >    Jeff
>
> ===================================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/nV8zxJgsCy9JAX0RAoMDAKCkhWzaYoOf4PT4xO+8deABSZuvwwCfSss/
9rIz1it4fWpQ3HVzFcK/qls=
=mOy2
-----END PGP SIGNATURE-----

