Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269090AbUJQJdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269090AbUJQJdn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 05:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269088AbUJQJdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 05:33:42 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:31129 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S269090AbUJQJdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 05:33:10 -0400
Organization: 
Date: Sun, 17 Oct 2004 12:32:49 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: John Gilbert <jgilbert@biomail.ucsd.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: ATI drivers and 2.6.9-rc4+
In-Reply-To: <41720210.1090706@biomail.ucsd.edu>
Message-ID: <Pine.GSO.4.61.0410171232270.10552@thanatos.csd.uoc.gr>
References: <41720210.1090706@biomail.ucsd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have a look at http://www.rage3d.net/board/showthread.php?t=33785167
Hope it helps.

Regards
 	Panagiotis Papadakos

On Sat, 16 Oct 2004, John Gilbert wrote:

> Hi all,
> I've fixed svgalib drivers and got them working under 2.6.9-rc4+ by replacing 
> "pci_find_class" with "pci_get_class".
> The ATI closed drivers have a problem with "remap_page_range". What does this 
> translate into (if it's that simple)?
> This seems to have changed from 2.6.8.
> Thanks in advance.
> John Gilbert
> jgilbert@biomail.ucsd.edu
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
