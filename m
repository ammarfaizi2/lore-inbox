Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbQKBXSY>; Thu, 2 Nov 2000 18:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129277AbQKBXSE>; Thu, 2 Nov 2000 18:18:04 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11584 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129250AbQKBXR7>; Thu, 2 Nov 2000 18:17:59 -0500
Date: Fri, 3 Nov 2000 00:17:51 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for better 2.2-based VM (do_try_to_free_pages fails, machine hangs)
Message-ID: <20001103001751.D29743@athlon.random>
In-Reply-To: <20001101133307.A10265@bylbo.nowhere.earth> <Pine.LNX.4.21.0011010940450.2774-100000@freak.distro.conectiva> <20001101174339.A1167@bylbo.nowhere.earth> <20001101174816.A18510@athlon.random> <20001102031517.A766@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001102031517.A766@werewolf.able.es>; from jamagallon@able.es on Thu, Nov 02, 2000 at 03:15:17AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 03:15:17AM +0100, J . A . Magallon wrote:
> "Includes" means that the full patch is not included in pre18 ?.

Only the strict bugfix broadcasted to l-k is been included in pre18.

> So, will the VM-pre17 work with pre18 ?.

It will generate a trivial reject but I just uploaded a new VM-global against
pre18 that generates exactly the same source code of the previous one against
pre17.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
