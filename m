Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUBQIwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 03:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUBQIwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 03:52:32 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:30157 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264137AbUBQIw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 03:52:29 -0500
Subject: Re: Where to find up to date documentation
From: "Yury V. Umanets" <umka@namesys.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200402161158.06060.m.watts@eris.qinetiq.com>
References: <200402161158.06060.m.watts@eris.qinetiq.com>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1077008003.3548.4.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Feb 2004 10:53:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 13:58, Mark Watts wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Can someone recommend the best place to look for documentation on writing a 
> device driver for the 2.6.x kernel? (Preferably something with a worked 
> example)
> 
> I'd prefer a hardcopy book, but I can only see ones for 2.4 driver 
> development.
> 
> Cheers,
> 
It depends on what driver type you are developing. Anyway, IMHO the best
way to see it is to read the sources in linux/drivers directory.
> Mark.
> 
> - -- 
> Mark Watts
> Senior Systems Engineer
> QinetiQ TIM
> St Andrews Road, Malvern
> GPG Public Key ID: 455420ED
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.3 (GNU/Linux)
> 
> iD8DBQFAMLBOBn4EFUVUIO0RAkl6AJ0adGg7fyud/njfY2byccccmV2kcACeI+gP
> i57VzaimePPv+VQpzxZt+Zs=
> =NmkT
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
umka

