Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263092AbUJ2ACz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263092AbUJ2ACz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbUJ2ACY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:02:24 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:61188 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263152AbUJ1X6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:58:21 -0400
Date: Fri, 29 Oct 2004 01:57:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>
Cc: dagb@cs.uit.no, jt@hpl.hp.com, irda-users@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] irda/qos.c: remove an unused function
Message-ID: <20041028235743.GQ3207@stusta.de>
References: <20041028222238.GP3207@stusta.de> <20041028162737.3d2debdf.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <20041028162737.3d2debdf.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, Oct 28, 2004 at 04:27:37PM -0700, David S. Miller wrote:
> 
> Ok, it looks like this whole enormous set of diffs are corrupted.
> They all are "patches of a patch" which won't apply correctly.
> 
> If you're going to send such a huge set of diffs out, please test
> them our and make sure they do apply properly before mailing
> them out.

I did test that they apply and compile.

Shit. It seems gpg escapes all minus signs when doing an inline 
signature of the message.

I'll resend the patches, thanks for the note.

> Thanks.

cu
Adrian

- -- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBgYd3mfzqmE8StAARAsQ+AJ9OB3lnny2AKUj2y42n3v6zm80CcACgjAoA
OP6vfM8VeyhUbnsKvdqVgzA=
=OJSY
-----END PGP SIGNATURE-----
