Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQKNVS2>; Tue, 14 Nov 2000 16:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQKNVST>; Tue, 14 Nov 2000 16:18:19 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:24838 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129103AbQKNVSI>; Tue, 14 Nov 2000 16:18:08 -0500
Date: Tue, 14 Nov 2000 15:47:59 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Andre Hedrick <andre@linux-ide.org>
cc: davej@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA66/100 errors...
In-Reply-To: <Pine.LNX.4.10.10011141031270.11879-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0011141545260.735-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Andre Hedrick wrote:

>Date: Tue, 14 Nov 2000 10:48:22 -0800 (PST)
>From: Andre Hedrick <andre@linux-ide.org>
>To: davej@suse.de
>Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
>     mharris@opensourceadvocate.org
>Content-Type: text/plain; charset=us-ascii
>Subject: Re: UDMA66/100 errors...
>
>
>Because he has not set the ignore valid bits and the 66 ribbon is not
>detected.

Ok, how do I do that?  I've got kernel 2.2.17 with the latest
2.2.17 IDE patch applied.

Without the 80 pin cable, my BIOS says "80 pin cable not
detected" or something like that.  When I use the 80 cable, the
message goes away so I know my BIOS is at least noticing the
cable.


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Windows 95(n) - 32-bit extensions and graphical shell for a 16-bit patch
to an 8-bit operating system originally coded for a 4-bit microprocessor,
written by a 2-bit company that can't stand 1 bit of competition. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
