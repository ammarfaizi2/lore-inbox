Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293341AbSBYIum>; Mon, 25 Feb 2002 03:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293349AbSBYIuc>; Mon, 25 Feb 2002 03:50:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:4874 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293341AbSBYIuW>;
	Mon, 25 Feb 2002 03:50:22 -0500
Message-ID: <3C79FA85.7010208@evision-ventures.com>
Date: Mon, 25 Feb 2002 09:49:09 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Paul Mackerras <paulus@samba.org>, Vojtech Pavlik <vojtech@suse.cz>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <Pine.LNX.4.10.10202241418420.8567-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As a point of reference for removal of the pci read/write space to the
> host, I strongly suggest that be left alone.  As for the removal of the
> settings file, may of the distributions use this as a means to issue
> script calls to enable and disable features w/o the use of an additional
> application like "hdparm".

You are sure the distros write to the PCI config space of the host chip
device or the IO registers at boot time????!!! In esp. since the
abolition in case did only just get introduced at 2.4.xx times???

Just show me one please!

