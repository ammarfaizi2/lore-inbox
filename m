Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTLXRC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 12:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTLXRC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 12:02:58 -0500
Received: from mout2.freenet.de ([194.97.50.155]:49899 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S263475AbTLXRC4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 12:02:56 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>
Subject: Re: allow process or user to listen on priviledged ports?
Date: Wed, 24 Dec 2003 18:02:34 +0100
User-Agent: KMail/1.5.93
References: <bscg1m$1eg$1@sea.gmane.org>
In-Reply-To: <bscg1m$1eg$1@sea.gmane.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312241802.42689.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 24 December 2003 17:43, Sven Köhler wrote:
> Hi,

Hi Sven,

> So is there any machanism to bind that permission (to listen on a
> priviledged tcp-port) to a specific user or a specific process?

I think (AFAIK) either grsec or selinux (or both) have the
ability to make the kernel accepting binds to those
privileged ports as normal user.

>
> Thx
>    Sven

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/6caxFGK1OIvVOP4RAupiAJ0SewsaODhJK8uQmmeQwEV8tGxp4QCfW4Fd
epUXG6pd5lERWvEIC+Ok7W0=
=7G/F
-----END PGP SIGNATURE-----
