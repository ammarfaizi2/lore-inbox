Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTEMGAD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTEMGAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:00:03 -0400
Received: from [195.95.38.160] ([195.95.38.160]:54513 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S263011AbTEMGAC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:00:02 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       Torrey Hoffman <thoffman@arnor.net>
Subject: Re: [2.420] Unexplained repeatable Oops
Date: Tue, 13 May 2003 08:12:37 +0200
User-Agent: KMail/1.5.1
References: <200305112052.51938.devilkin-lkml@blindguardian.org> <200305130740.45250.devilkin-lkml@blindguardian.org> <200305131549.13371.kernel@kolivas.org>
In-Reply-To: <200305131549.13371.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305130812.42741.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 13 May 2003 07:49, Con Kolivas wrote:
>
> mprime will pick up more subtle things than cpuburn will. It's not purely a
> temperature of the cpu issue. It may be the bus.
> Try underclocking your bus/cpu. I run a P3 933 (133x7) at 868 (124x7) and
> all problems go away. The same cpu works fine overclocked on a different
> motherboard.

IC.

Little question though: any idea what actually _would_ happen if it were an 
agp card problem? As far as I know (and can relate to previous problems) this 
usually causes a blank screen, or distorted video - but not crashes where X 
segfaults back to the console, or where the entire system goes hanging...

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wIzXpuyeqyCEh60RAjSKAJwM35Hj7Vna8/hKBF8rEl6/2mNh/ACfZ1qS
VNLUSF7228WI/fNVoizGvZs=
=JKid
-----END PGP SIGNATURE-----

