Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLSROU>; Tue, 19 Dec 2000 12:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLSROB>; Tue, 19 Dec 2000 12:14:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15168 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129319AbQLSRNu>; Tue, 19 Dec 2000 12:13:50 -0500
Date: Tue, 19 Dec 2000 17:43:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Black <mblack@csihq.com>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18aa2 weird problem
Message-ID: <20001219174308.D32152@athlon.random>
In-Reply-To: <03a001c069cd$8a593c50$e1de11cc@csihq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a001c069cd$8a593c50$e1de11cc@csihq.com>; from mblack@csihq.com on Tue, Dec 19, 2000 at 10:08:27AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 10:08:27AM -0500, Mike Black wrote:
> Rebooting this machine to 2.2.17-RAID works just fine

Which RAID patch are you using against 2.2.17 exactly? Also make sure you're
using exactly the same kernel configuration of 2.2.17-RAID.

> Might there be a problem with RAID5 as root?

Might be possible, I've not tested RAID5 as root (though I tested raid5 in
non-root mountpoints). OTOH you said it mounted things correctly and it somehow
booted, so I'm not sure what's going wrong... Just make sure it's really a
kernel issue ;).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
