Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVFVJ4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVFVJ4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVFVJy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:54:28 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:36561 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S262828AbVFVJvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:51:40 -0400
Message-ID: <42B935D9.7010608@stesmi.com>
Date: Wed, 22 Jun 2005 11:56:41 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <42B8E834.5030809@slaphack.com>
In-Reply-To: <42B8E834.5030809@slaphack.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi David

> And here is the crucial point.  Reiser4 is usable and useful NOW, not
> after it has undergone massive surgery, and Namesys is bankrupt, and
> users have given up and moved on to XFS.  But the massive surgery should
> happen eventually, partly to make all filesystems better (see below),
> and partly to make the transition easier and more palatable for those
> who don't work for Namesys.

Sometimes someone comes with "I have this code NOW and if we just merge
it I'll fix it up properly". It's rejected, stating "come back when
you've fixed it up".

We don't even have that here. We have "I have this code NOW and when
it's merged I have no intention of fixing it up properly".

In my eyes I'd rather take the first one than the second, there at least
there's the INTENTION of fixing it up.

Oh and btw, I'm not pro- or against- reiserfs in any way. I haven't
tried reiserfs4 but I hear it's good so don't take this is a statement
of my like or dislike of it, I'm just stating something worth thinking
about.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCuTXZBrn2kJu9P78RAi0JAJwIp6uyAd3AL4mgSBMAH59h7CrklQCfRW+V
8ZlZqxHwnpqpHa8OURtUEuw=
=OD/E
-----END PGP SIGNATURE-----
