Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbTGDBnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTGDBm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:42:59 -0400
Received: from [208.199.87.79] ([208.199.87.79]:59336 "EHLO amboise.dolphin")
	by vger.kernel.org with ESMTP id S265629AbTGDBms convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:42:48 -0400
Date: Thu, 3 Jul 2003 18:56:54 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
X-X-Sender: fgouget@amboise.dolphin
To: Dan Kegel <dkegel@ixiacom.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: re: Spelling fixes
In-Reply-To: <3F03580E.4080203@ixiacom.com>
Message-ID: <Pine.LNX.4.44.0307031837170.29535-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Dan Kegel wrote:

> Patch looks pretty good, if big.  I haven't checked more than 10% of it, though.
> You might want to split it up some as you intended.

I have split it along directory lines. I also updated it for 2.5.74 and
included fixes for a couple more typos that people pointed me to. The
latest patches can be found at:

http://fgouget.free.fr/tmp/linux-spelling/

The files are smaller but maybe they need to be split some more:
    324 linux-2.5.74-Documentation.diff
    102 linux-2.5.74-arch-cris.diff
    581 linux-2.5.74-arch.diff
    173 linux-2.5.74-drivers-char.diff
    275 linux-2.5.74-drivers-isdn.diff
    177 linux-2.5.74-drivers-mtd.diff
    774 linux-2.5.74-drivers-net.diff
    643 linux-2.5.74-drivers-scsi.diff
    129 linux-2.5.74-drivers-usb.diff
    706 linux-2.5.74-drivers.diff
    215 linux-2.5.74-fs.diff
    769 linux-2.5.74-include.diff
    223 linux-2.5.74-net.diff
     21 linux-2.5.74-scripts.diff
    156 linux-2.5.74-sound.diff


> I'll link to your script from http://kegel.com/kerspell/

Cool. I uploaded it to my site. It can be downloaded from:

http://fgouget.free.fr/typos/typos


-- 
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
                           La terre est une bêta...

