Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263206AbTDCBWa>; Wed, 2 Apr 2003 20:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbTDCBWa>; Wed, 2 Apr 2003 20:22:30 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:27290
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S263206AbTDCBW3>; Wed, 2 Apr 2003 20:22:29 -0500
Message-ID: <3E8B8F31.5030407@redhat.com>
Date: Wed, 02 Apr 2003 17:32:33 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why moving driver includes ?
References: <mailman.1049324411.25620.linux-kernel2news@redhat.com> <200304030045.h330jok10685@devserv.devel.redhat.com>
In-Reply-To: <200304030045.h330jok10685@devserv.devel.redhat.com>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Pete Zaitcev wrote:

> Yeah, but what does it have to do with kernel? You should have
> gotten Uli to add them to glibc.

Headers like have no place in glibc either.  There should be one or more
separate packages which distribute kernel headers.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+i4832ijCOnn/RHQRAo+3AJ9VSy96p4dq8DJ+Mtd0oZTCCOswxgCdHl9d
daw5lnlXKUuciCSTKSt3Jxc=
=ugh8
-----END PGP SIGNATURE-----

