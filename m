Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291430AbSBHGMj>; Fri, 8 Feb 2002 01:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291432AbSBHGMU>; Fri, 8 Feb 2002 01:12:20 -0500
Received: from out018pub.verizon.net ([206.46.170.96]:34519 "EHLO
	out018.verizon.net") by vger.kernel.org with ESMTP
	id <S291430AbSBHGMK>; Fri, 8 Feb 2002 01:12:10 -0500
Date: Fri, 8 Feb 2002 01:09:46 -0500
From: Skip Ford <skip.ford@verizon.net>
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.4-pre3 and IDE changes
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C634346.1010405@nyc.rr.com> <Pine.LNX.4.10.10202071953330.15165-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10202071953330.15165-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Thu, Feb 07, 2002 at 07:54:09PM -0800
Message-Id: <20020208061209.LZYM25425.out018.verizon.net@pool-141-150-235-204.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andre Hedrick wrote:
> 
> I repeat that is a diagnostic layer and is to never be called from the
> kernel, it is a user-space only and will go away.

Maybe so, but I got pre3 to boot finally with that patch and it works
fine.

- -- 
Skip  ID: 0x7EDDDB0A
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAjxja3oACgkQBMKxVH7d2wpoqQCgmvuwyMF+NtjgFP3zhZguLjMb
uiEAniwZm7fifpuvWjIdhUCNcbnI8JVM
=ACIo
-----END PGP SIGNATURE-----
