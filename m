Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUCDCSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbUCDCSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:18:18 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:5263 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP id S261406AbUCDCR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:17:28 -0500
Message-ID: <40469194.5080506@redhat.com>
Date: Wed, 03 Mar 2004 18:16:52 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040302
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random>
In-Reply-To: <20040304005542.GZ4922@dualathlon.random>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrea Arcangeli wrote:

> This is just like the kernel patches people proposes when they get
> vmalloc LDT allocation failure, because they run with the i686 glibc
> instead of the only possibly supported i586 configuration. It makes no
> sense to hide a glibc inefficiency

You apparently still haven't gotten any clue since your whining the last
time around.  Absolute addresses are a fatal mistake.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFARpGU2ijCOnn/RHQRAhs3AJ0XEZ5VGb40VAIPuO4negyo7cx/WwCbBrN6
EFZ7UnY7W/it0sUiq6Dodeg=
=KSMr
-----END PGP SIGNATURE-----
