Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262123AbSJEHqI>; Sat, 5 Oct 2002 03:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262122AbSJEHqH>; Sat, 5 Oct 2002 03:46:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4622 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262123AbSJEHqH>; Sat, 5 Oct 2002 03:46:07 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: initramfs work
Date: 5 Oct 2002 00:51:23 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <anm5lr$m58$1@cesium.transmeta.com>
References: <200210050512.g955CSx86532@sullivan.realtime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200210050512.g955CSx86532@sullivan.realtime.net>
By author:    "Milton D. Miller II" <miltonm@realtime.net>
In newsgroup: linux.dev.kernel
> 
> Al,
>   Is there somewhere one could see what you are planning to merge?  
> 
> I was following the klibc dicussion list, but the archiver went slient after
> August.
> 
> I like the idea in general, but I wasn't sure where this was going.   It
> looked like the discussion there was going for replacing the do_mounts with
> the kernel uncpio/uncompress followed by a bunch of small utilities and
> scripts.  I had some other ideas that I played with, but depend on starting
> with a single binary to make a lot of sense (going for the multi-call binary
> base approach).   (This would leave the initrd file for the user space).
> 
> If there is some place to get a preview I would appreciate it.
> 

The next step is to get it all merged into the kernel tree.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
