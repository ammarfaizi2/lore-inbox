Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261372AbULETsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbULETsk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 14:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbULETsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 14:48:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261372AbULETsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 14:48:38 -0500
Message-ID: <41B365E2.7040900@redhat.com>
Date: Sun, 05 Dec 2004 11:47:46 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a5) Gecko/20041115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: host name length
References: <40521AA6.7070308@redhat.com> <20041203160538.77a22864.rddunlap@osdl.org>
In-Reply-To: <20041203160538.77a22864.rddunlap@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Randy.Dunlap wrote:

> Can you show/tell me where _POSIX_HOST_NAME_MAX is specified to be
> at least 256?

XBD, page 255 (in the 2004 edition), <limits.h>

{_POSIX_HOST_NAME_MAX}
  Maximum length of a host name (not including the terminating null) as
  returned from the /gethostname()/ function.
  Value: 255

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBs2Xi2ijCOnn/RHQRAlzqAJ0aGjR6ptG0GfhEK9fK/wh/jHz5FwCgne9q
8CuFUfI27KMdic4+3UDc3mk=
=YoSa
-----END PGP SIGNATURE-----
