Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbQKBACQ>; Wed, 1 Nov 2000 19:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130658AbQKBACG>; Wed, 1 Nov 2000 19:02:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14348 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130649AbQKBABw>; Wed, 1 Nov 2000 19:01:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: working userspace nfs v3 for linux?
Date: 1 Nov 2000 16:01:29 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tqasp$d1k$1@cesium.transmeta.com>
In-Reply-To: <linux.kernel.3A008510.FAE271A1@holly-springs.nc.us> <slrn9015t8.u5t.wnoise@barter.ugcs.caltech.edu> <3A00A84E.F3A1C585@holly-springs.nc.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A00A84E.F3A1C585@holly-springs.nc.us>
By author:    Michael Rothwell <rothwell@holly-springs.nc.us>
In newsgroup: linux.dev.kernel
>
> Aaron Denney wrote:
> > I am not aware of any userspace NFSv3 server.  Your best bet would
> > probably to take the v2 server and mutate it.  Why do you want this beast?
> 
> So I can use Linux rather than Solaris 7 and the Solstice Disk Suite,
> which performs like crap thanks to UFS, and the Linux NFS v2
> implementation.
> 

The point is, why not use knfsd.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
