Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTIIDzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 23:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263919AbTIIDzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 23:55:19 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:54985
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262123AbTIIDzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 23:55:16 -0400
Message-ID: <3F5D4EFA.30102@redhat.com>
Date: Mon, 08 Sep 2003 20:54:34 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030904 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeremy Fitzhardinge <jeremy@goop.org>, mingo@redhat.com, roland@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
References: <1061424262.24785.29.camel@localhost.localdomain>	<20030820194940.6b949d9d.akpm@osdl.org>	<1063072786.4004.11.camel@localhost.localdomain>	<20030908191215.22f501a2.akpm@osdl.org>	<1063073637.4004.14.camel@localhost.localdomain> <20030908202147.3cba2ecd.akpm@osdl.org>
In-Reply-To: <20030908202147.3cba2ecd.akpm@osdl.org>
X-Enigmail-Version: 0.81.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:
> I think so?

Definitely.  All occurrences have to be changed.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/XU762ijCOnn/RHQRAivlAJ44IyipfOulKbyIXFc2KtKNAChnAACcD9IP
Di3DV6lM6+59ujhFwYK41mE=
=6Ofq
-----END PGP SIGNATURE-----

