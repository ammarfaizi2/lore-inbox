Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbTDGVcW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263675AbTDGVcW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:32:22 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:34749
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263672AbTDGVcV (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 17:32:21 -0400
Message-ID: <3E91F0FD.1040507@redhat.com>
Date: Mon, 07 Apr 2003 14:43:25 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030406
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fredrik Tolf <fredrik@dolda2000.cjb.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <b6qruf$elf$1@cesium.transmeta.com> <200304072255.47254.fredrik@dolda2000.cjb.net>
In-Reply-To: <200304072255.47254.fredrik@dolda2000.cjb.net>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Fredrik Tolf wrote:

> Anyway, while we're on the subject, is it just me who would like to see a
> fexec() call?

If you'd run an up-to-date system (e.g., RHL9) you'd have fexecve() already.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+kfD92ijCOnn/RHQRAhO2AKCOD1ugVpxvM6shymsylznP/tsYmQCfbODX
n+wHxIQMq9G8Tfi2/0seh7I=
=EJxb
-----END PGP SIGNATURE-----

