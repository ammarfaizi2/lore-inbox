Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbTHSSxj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTHSSuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:50:39 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:65250
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261278AbTHSSt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:49:56 -0400
Message-ID: <3F427122.9040408@redhat.com>
Date: Tue, 19 Aug 2003 11:49:06 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
References: <3F4268C1.9040608@redhat.com>
In-Reply-To: <3F4268C1.9040608@redhat.com>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ulrich Drepper wrote:

> Go into a directory mounted via NFS.  You need write access.  Then
> execute this little program:

Just to be clear: the client is running 2.6.  The server in my case runs
a 2.4 kernel.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/QnEj2ijCOnn/RHQRAmu9AKCJk8Khn/za3DGP/XAeioes9zk+PgCdEizd
HrSpPHo7v3KmOZRjLTeIKJk=
=XNdG
-----END PGP SIGNATURE-----

