Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUD0FXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUD0FXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbUD0FXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:23:51 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:60288 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S263777AbUD0FXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:23:11 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Date: Mon, 26 Apr 2004 22:23:06 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: 2.6.6-rc2-mm2 + Adaptec I2O
In-Reply-To: <408DE95F.5010201@tequila.co.jp>
Message-ID: <Pine.LNX.4.58.0404262221490.17702@dlang.diginsite.com>
References: <408DE95F.5010201@tequila.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received a patch that works with 2.6.x x<=4 but it breaks with 2.6.5 so
for now I am sticking with 2.6.4 and hopeing that I don't have to swap out
all these raid controllers.

David Lang


On Tue, 27 Apr 2004, Clemens Schwaighofer wrote:

> Date: Tue, 27 Apr 2004 14:02:23 +0900
> From: Clemens Schwaighofer <cs@tequila.co.jp>
> To: Linux Kernel ML <linux-kernel@vger.kernel.org>
> Subject: 2.6.6-rc2-mm2 + Adaptec I2O
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi,
>
> oldies but goldies ...
>
> Some old game, same stuff again. Linux-2.6.6-rc2 + mm2 and the adaptec
> i2o is still not compiling. There is a patch swirring around the
> internet for 2.6.5 where the kernel compiles (thought i couldn't reboot
> the box yet, so no "real" expierence).
>
> What is the status? Will there be ever a 2.6.x kernel with a working i2o
> driver? Do I have to blackmail Adaptec ;) ?
>
> lg, clemens
> - --
> Clemens Schwaighofer - IT Engineer & System Administration
> ==========================================================
> TEQUILA\Japan, 6-17-2 Ginza Chuo-ku, Tokyo 104-8167, JAPAN
> Tel: +81-(0)3-3545-7703            Fax: +81-(0)3-3545-7343
> http://www.tequila.co.jp
> ==========================================================
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
>
> iD8DBQFAjelejBz/yQjBxz8RAickAJ9WpfJvZ/kH0tLPqXP3zSSUlwH4ZwCfZUMw
> usTbWV0xDVrMvZVay7Hq+GQ=
> =vVqS
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
