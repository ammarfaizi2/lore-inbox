Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUCGKq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 05:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbUCGKq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 05:46:27 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:44467
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261802AbUCGKq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 05:46:26 -0500
Message-ID: <404AFD72.3070306@redhat.com>
Date: Sun, 07 Mar 2004 02:46:10 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike@theoretic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Potential bug in fs/binfmt_elf.c?
References: <1078508281.3065.33.camel@linux.littlegreen> <404A1C71.3010507@redhat.com> <1078607410.10313.7.camel@linux.littlegreen> <404ABD06.4060607@redhat.com> <pan.2004.03.07.09.58.43.675972@codeweavers.com>
In-Reply-To: <pan.2004.03.07.09.58.43.675972@codeweavers.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike Hearn wrote:
> One quick question - you said binfmt_elf is not a
> generic ELF interpreter, but the one in glibc presumably is yes?

No.  It only handles what is necessary.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFASv1y2ijCOnn/RHQRAihlAKCa6gGblyruVtYqk5OQFf3IvL4ELQCgyY5/
lkq7yoQelRbOFVuUwAAvcmk=
=MFBI
-----END PGP SIGNATURE-----
