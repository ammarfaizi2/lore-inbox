Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTIFRcj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 13:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbTIFRcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 13:32:39 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:37301
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261152AbTIFRci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 13:32:38 -0400
Message-ID: <3F5A1A11.5060809@redhat.com>
Date: Sat, 06 Sep 2003 10:32:01 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030904 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: today's futex changes
References: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
X-Enigmail-Version: 0.81.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hugh Dickins wrote:

> Does the patch below work for you, Ulrich?

Indeed it does.  This was so far only on a UP HT machine.  I'll
hopefully later on can run it on a bigger SMP machine.  Good work.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/WhoR2ijCOnn/RHQRAubxAJ9a4UeDkIQ61NBDIkwWWT8myvbsxACdEsnl
xyLcJXc57avwpVltynzRcQE=
=X+Xh
-----END PGP SIGNATURE-----

