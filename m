Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTL2SM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTL2SM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:12:58 -0500
Received: from linuxhacker.ru ([217.76.32.60]:1428 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263632AbTL2SMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:12:49 -0500
Date: Mon, 29 Dec 2003 20:12:40 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs-3.6.25 (2.4.21) ., instead of .., rsync Q
Message-ID: <20031229181240.GV357030@linuxhacker.ru>
References: <200312291454.hBTEspwF025036@car.linuxhacker.ru> <Pine.LNX.4.44.0312291859310.20257-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312291859310.20257-100000@poirot.grange>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Dec 29, 2003 at 07:05:06PM +0100, Guennadi Liakhovetski wrote:
> > GL> Don't know if this would be of much help, though - I've already removed
> > GL> the directory (rmdir worked ok), I had to do a backup, and with that
> > GL> structure rsync couldn't go further.
> > What if you try to run memtest86 to see if you have good RAM?
> Hm, you mean it would have gone after a reboot?... No, don't think I tried

Not necessary. Corrupted block might have been written to the disk as well.

> to reboot. And, as said above, the directory is gone, so, can't check. I
> did try to run the memtest at some point, once it did catch an error...

Ah, so memtest gave an error. Then I am surprised you still run on that memory.

Bye,
    Oleg
