Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262161AbTCHTp3>; Sat, 8 Mar 2003 14:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbTCHTp3>; Sat, 8 Mar 2003 14:45:29 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:64643
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S262161AbTCHTp2>; Sat, 8 Mar 2003 14:45:28 -0500
Message-ID: <3E6A4B1E.1010205@redhat.com>
Date: Sat, 08 Mar 2003 11:57:18 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc D Bumble <marc_bumble@cpinternet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Plans for Posix sem_init() for pshared = 1 ?
References: <m3smtxbr7r.fsf@cadence.glidepath.org>
In-Reply-To: <m3smtxbr7r.fsf@cadence.glidepath.org>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marc D Bumble wrote:
> Is anyone working on developing the Posix semaphores for Linux?

Already implemented.

http://people.redhat.com/drepper/posix-option-groups.html#THREAD_PROCESS_SHARED

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+akse2ijCOnn/RHQRAherAKC+iETyDpb9z86YvvkZf/0/9fYsGwCguC2d
9Bbf1JhXJ5IvWUWDtARLTMg=
=wTeU
-----END PGP SIGNATURE-----

