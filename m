Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTHUDGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 23:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbTHUDGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 23:06:49 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:51179
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262364AbTHUDGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 23:06:48 -0400
Message-ID: <3F443708.1060800@redhat.com>
Date: Wed, 20 Aug 2003 20:05:44 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
References: <3F4268C1.9040608@redhat.com> <shszni499e9.fsf@charged.uio.no> <20030820192409.A2868@pclin040.win.tue.nl> <16195.49464.935754.526386@charged.uio.no> <20030820215246.B3065@pclin040.win.tue.nl>
In-Reply-To: <20030820215246.B3065@pclin040.win.tue.nl>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andries Brouwer wrote:

> It should be. But it isnt. I propose the following patch
> (with whitespace damage):
> [...]

This indeed fixes the problem.  Thanks,

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/RDcI2ijCOnn/RHQRAtBPAJ4j1oPL2DkdNwXQlH4+j2VxNppEowCgpKWM
4tezLlkNQJzwvzsuwb3U0uY=
=I0bD
-----END PGP SIGNATURE-----

