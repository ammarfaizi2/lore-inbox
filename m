Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWEUH5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWEUH5M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 03:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWEUH5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 03:57:12 -0400
Received: from mx27.mail.ru ([194.67.23.63]:62575 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1751499AbWEUH5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 03:57:11 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.17
Date: Sun, 21 May 2006 11:57:07 +0400
User-Agent: KMail/1.9.1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605211157.08709.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> The updated 2.6.16.y git tree can be found at:
>        
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git

when is it expected to hit repository?

{pts/2}% git rev-list --max-count=1 --pretty stable
commit 22ddf44d54d0b2326f7b233e836e7155d45d3a7d
Author: Chris Wright <chrisw@sous-sol.org>
Date:   Wed May 10 18:56:24 2006 -0700

    Linux 2.6.16.16

{pts/2}% git fetch stable
* refs/heads/stable: same as branch 'master' of 
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEcB1UR6LMutpd94wRAp9cAJsGQlyzuUqtPz/TiDJ0Z/DPtloJ3QCffX3b
Z39ErQOzKUXmdbLUnQpSWtc=
=wERX
-----END PGP SIGNATURE-----
