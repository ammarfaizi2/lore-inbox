Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129593AbQK1FXG>; Tue, 28 Nov 2000 00:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129834AbQK1FW5>; Tue, 28 Nov 2000 00:22:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47115 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129593AbQK1FWq>; Tue, 28 Nov 2000 00:22:46 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: A20 gate (was: KERNEL BUG: console not working in linux)
Date: 27 Nov 2000 20:52:12 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vvdls$8bd$1@cesium.transmeta.com>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD86@orsmsx31.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD86@orsmsx31.jf.intel.com>
By author:    "Dunlap, Randy" <randy.dunlap@intel.com>
In newsgroup: linux.dev.kernel
> 
> Just curious: Are you (Alan?) saying this ("standard") based on the
> unpublished IBM PC specs (well, it was when I needed it around
> 1990; don't know about now ???).  Or do you have a copy
> of it?  They were mighty hard to come by, and I was working
> on a contract for IBM at the time (not at Intel).
> 

There is nothing unpublished about them.  They are old, but definitely
published.  As far as System Control Port A, they were published in
the PS/2 reference manuals.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
