Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRATSZf>; Sat, 20 Jan 2001 13:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131033AbRATSZ0>; Sat, 20 Jan 2001 13:25:26 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:18002 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129561AbRATSZS>; Sat, 20 Jan 2001 13:25:18 -0500
Date: Sat, 20 Jan 2001 19:25:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: andersg@0x63.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: lvm-oops in 2.4.1pre8
Message-ID: <20010120192553.K8717@athlon.random>
In-Reply-To: <20010120184106.A355@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010120184106.A355@h55p111.delphi.afb.lu.se>; from andersg@0x63.nu on Sat, Jan 20, 2001 at 06:41:06PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 06:41:06PM +0100, andersg@0x63.nu wrote:
> hi,
> 
> got this oops when doing a 
> vgextend -v vgroot /dev/ide/host2/bus0/target0/lun0/part2 \
> /dev/ide/host2/bus1/target0/lun0/part2

You should upgrade to 0.9.1_beta2 that should merge all the known fixes out
there. It's planned for inclusion into 2.4.1.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
