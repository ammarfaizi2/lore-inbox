Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbTEOSDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTEOSDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:03:49 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:6331 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S264139AbTEOSDs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:03:48 -0400
Message-ID: <3EC3D96C.3030905@redhat.com>
Date: Thu, 15 May 2003 11:16:12 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
References: <Pine.LNX.3.96.1030515135628.30631A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030515135628.30631A-100000@gatekeeper.tmr.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bill Davidsen wrote:

> He didn't say static linking he said static library. I assume he meant a
> .a lib instead of a .so lib. One which has elements which are made part of
> the executable instead of being part of a shared library.

And in what way does this not match what I say?  The content of the DSO
and the archive is identical functionality-wise and therefore none of
this ever has any influence on whether futexes are used or not.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+w9ls2ijCOnn/RHQRAsfAAJ9sSbudcXdNSHYAB6ICm/fXWRhuQQCgqmMD
cwxSzwuFEeeS6ACGonakUy8=
=+/L9
-----END PGP SIGNATURE-----

