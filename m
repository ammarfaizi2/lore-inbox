Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTKDSgd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 13:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTKDSgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 13:36:33 -0500
Received: from mout1.freenet.de ([194.97.50.132]:33730 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S262458AbTKDSgc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 13:36:32 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] [2.6.0-test9 ALSA] ALSA-OSS-emulation unable to register
Date: Tue, 4 Nov 2003 21:35:05 +0100
User-Agent: KMail/1.5.4
References: <200311021458.59759.mbuesch@freenet.de> <200311041630.22807.mbuesch@freenet.de> <s5hism0tacc.wl@alsa2.suse.de>
In-Reply-To: <s5hism0tacc.wl@alsa2.suse.de>
Cc: alsa-devel@alsa-project.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311042136.19042.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 04 November 2003 16:36, Takashi Iwai wrote:
> the first argument is "enable".  "index" is the second argument.
> so, you'll need to pass "snd-ens1371=1,1"

Now neither ALSA, nor OSS-emu works. :)

> Takashi

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/qA3BoxoigfggmSgRAkBxAJ9fJnOGw+qCv30AUA7TrXQuBTM3JwCePPAT
HP5FlPbzkbDMCED/ra4BSYU=
=6RlG
-----END PGP SIGNATURE-----

