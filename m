Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUKHNWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUKHNWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 08:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbUKHNWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 08:22:10 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:50124 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261530AbUKHNWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 08:22:06 -0500
Message-ID: <418F72F9.5050900@g-house.de>
Date: Mon, 08 Nov 2004 14:22:01 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Sumesh <sumesh_kumar@persistent.co.in>
Subject: Re: Ensoniq ES1371 not working.
References: <418F09F5.10406@persistent.co.in>
In-Reply-To: <418F09F5.10406@persistent.co.in>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sumesh schrieb:
> Hi,
> 
>     I have a Ensoniq ES1371 sound card on a RH 9 (2.4.20-8). When i try
> to load my module i get the following errors.
> 
> shell -  insmod /lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o
> /lib/modules/2.4.20-8/kernel/drivers/sound/es1371.o: unresolved symbol
> unregister_sound_mixer_R7afc9d8a

[...]

this is the standard RH kernel? or did you re-compile their source?
if yes, did you "make clean" before and "make modules_install" afterwards?

Christian.
- --
BOFH excuse #317:

Internet exceeded Luser level, please wait until a luser logs off before
attempting to log back on.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBj3L4+A7rjkF8z0wRAjoYAKC6+7YFi+75ENZTeuSvza2xfn/oIgCgzWOM
oBfSEyM52hB87WC3aZ1PEz8=
=qdIs
-----END PGP SIGNATURE-----
