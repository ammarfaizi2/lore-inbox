Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268713AbRG3XC1>; Mon, 30 Jul 2001 19:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbRG3XCS>; Mon, 30 Jul 2001 19:02:18 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:20560 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S268674AbRG3XCI>; Mon, 30 Jul 2001 19:02:08 -0400
Date: Mon, 30 Jul 2001 17:56:25 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
In-Reply-To: <Pine.GSO.4.21.0107300137550.16140-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1010730175545.27870C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, Alexander Viro wrote:
> Stuff that went in userland: choosing and mounting root, unpacking/loading
> initrd, running /linuxrc, handling nfsroot, finding and starting final
> init - basically, everything after do_basic_setup().

Eventually I would like to see firmware uploading in initramfs,
instead of compiling firmware images into the kernel...

	Jeff




