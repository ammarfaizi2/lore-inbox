Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSJOV3d>; Tue, 15 Oct 2002 17:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbSJOV3d>; Tue, 15 Oct 2002 17:29:33 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:49884 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S264907AbSJOV3a>; Tue, 15 Oct 2002 17:29:30 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "David S. Miller" <davem@redhat.com>, maxk@qualcomm.com
Subject: Re: [RFC] Rename _bh to _softirq
Date: Wed, 16 Oct 2002 07:27:17 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20021015131839.01c1a008@mail1.qualcomm.com> <5.1.0.14.2.20021015135529.051b49b0@mail1.qualcomm.com> <20021015.135812.111263418.davem@redhat.com>
In-Reply-To: <20021015.135812.111263418.davem@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210160727.17190.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 16 Oct 2002 06:58, David S. Miller wrote:
>    From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
>    Date: Tue, 15 Oct 2002 14:02:22 -0700
>
>    I guess we should then have some kinda readme that explains what
>    all those things are. And the BH context covers softirqs and tasklets.
>
> That sounds fine.
Documentation/DocBook/kernel-hacking.tmpl

It is such a fine idea, Rusty already did it...

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9rIg1W6pHgIdAuOMRAv7zAJ95Eo1zgh2LWYxesk+LlWQ+U8O2OACfb8Qa
Kfx4vfcbofHxfr6muMvi1WE=
=1Ukc
-----END PGP SIGNATURE-----

