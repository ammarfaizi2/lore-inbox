Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTESKpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTESKpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:45:25 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:47232 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S262379AbTESKpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:45:23 -0400
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm7
References: <20030519012336.44d0083a.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 May 2003 12:58:38 +0200
In-Reply-To: <20030519012336.44d0083a.akpm@digeo.com>
Message-ID: <874r3r2of5.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton <akpm@digeo.com> writes:
>
> [SNIP]
>

Caught this one during make modules_install:

WARNING: /lib/modules/2.5.69-mm7/kernel/fs/ext2/ext2.ko needs unknown symbol __bread_wq

mvh,
A
- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+yLjbCQ1pa+gRoggRAg2UAKCSjvT4uHD6lENM0O5lqoZSZZ0QigCgq0rm
IA+CUUNeFXrjOPfbq9V7/f8=
=bcye
-----END PGP SIGNATURE-----
