Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBGTZD>; Wed, 7 Feb 2001 14:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129313AbRBGTYx>; Wed, 7 Feb 2001 14:24:53 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:12040 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129032AbRBGTYo>;
	Wed, 7 Feb 2001 14:24:44 -0500
Message-ID: <3A81A0C2.B28FB17@mandrakesoft.com>
Date: Wed, 07 Feb 2001 14:23:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: davej@suse.de
CC: Alan Cox <alan@redhat.com>, becker@scyld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hamachi not doing pci_enable before reading resources
In-Reply-To: <Pine.LNX.4.31.0102071914210.17543-100000@athlon.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied locally: pci_device_enable() cleanups for hamachi, eepro100,
starfire

I'll have to look at ne2k-pci, I think a patch in -ac may be spurious.

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
