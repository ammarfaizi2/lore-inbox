Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131998AbRAGUea>; Sun, 7 Jan 2001 15:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135483AbRAGUeU>; Sun, 7 Jan 2001 15:34:20 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:14968 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S131998AbRAGUeI>;
	Sun, 7 Jan 2001 15:34:08 -0500
Message-ID: <3A58BF5C.1090505@valinux.com>
Date: Sun, 07 Jan 2001 12:11:24 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael D. Crawford" <crawford@goingware.com>
CC: linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
In-Reply-To: <3A57A83B.702CEC98@goingware.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Could XFree86 4.0.2 fix this?  I had been waiting until the binary packages were
> available from ftp.slackware.com because Patrick Volkerding lays out the
> directories in a slightly different manner that he argues pretty convincingly is
> preferable, but it would be a drag for me to reproduce by building it myself.

XFree 4.0.2 will fix this.

> (EE) r128(0): R128DRIScreenInit failed (DRM version = 2.1.2, expected 1.0.x). 
> Disabling DRI.

We made binary incompatible device interface changes with 4.0.2.  These 
driver changes resulted in a more stable / faster / cleaner Rage 128 driver.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
