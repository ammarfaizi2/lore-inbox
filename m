Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262963AbUJ1LCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUJ1LCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262966AbUJ1LCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:02:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44040 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262963AbUJ1LCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:02:36 -0400
Date: Thu, 28 Oct 2004 13:02:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: C Wegrzyn <lists@garbagedump.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Omission on 2.6.9?
Message-ID: <20041028110204.GA3207@stusta.de>
References: <41763B30.7030500@garbagedump.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <41763B30.7030500@garbagedump.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, Oct 20, 2004 at 10:17:20AM +0000, C Wegrzyn wrote:

> I just built the 2.6.9 kernel and noticed that PWC driver isn't present. 
> Is this an accidental omission or something else?

It was removed, but will hopefully be back in 2.6.10.

You can get it if you apply the latest -ac patch from [1].

> Thanks,
> Chuck Wegrzyn

cu
Adrian

[1] ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgNGsmfzqmE8StAARAs1SAJwNNQW+jNYN8AzNaLQnCzXMwBejjQCgjpzL
DEcwB4n6RIhwEC+yHI6wBzw=
=ESn+
-----END PGP SIGNATURE-----
