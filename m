Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265660AbSJSTbh>; Sat, 19 Oct 2002 15:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSJSTbh>; Sat, 19 Oct 2002 15:31:37 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:39331
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265660AbSJSTbg>; Sat, 19 Oct 2002 15:31:36 -0400
Message-ID: <3DB1B3DF.3090009@redhat.com>
Date: Sat, 19 Oct 2002 12:34:55 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021014
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Mark Gross <mark@thegnar.org>,
       NPT library mailing list <phil-list@redhat.com>,
       Daniel Jacobowitz <dan@debian.org>, Mark Kettenis <kettenis@gnu.org>,
       mgross <mgross@unix-os.sc.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
References: <Pine.LNX.3.96.1021019152330.29078J-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1021019152330.29078J-100000@gatekeeper.tmr.com>
X-Enigmail-Version: 0.65.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bill Davidsen wrote:

> But the terminating '\0' is required in ELF, no?


It is required and the whole discussion is unnecessary now since the
appropriate gdb patch has been submitted and has aready been approved
several months ago.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9sbPf2ijCOnn/RHQRAsjXAJsFLA7AOQ5/sCSHTyCJMHFO3hlUcACgsn71
n3fLrMKl8n+VTs5UQoVFEVs=
=rQVr
-----END PGP SIGNATURE-----

