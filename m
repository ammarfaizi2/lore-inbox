Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129655AbQK2Jts>; Wed, 29 Nov 2000 04:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129761AbQK2Jti>; Wed, 29 Nov 2000 04:49:38 -0500
Received: from 62-6-231-191.btconnect.com ([62.6.231.191]:54788 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129655AbQK2Jt0>;
        Wed, 29 Nov 2000 04:49:26 -0500
Date: Wed, 29 Nov 2000 09:20:52 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: corruption
In-Reply-To: <Pine.GSO.4.21.0011290351080.14112-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011290918440.1425-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Alexander Viro wrote:
> 
> I'ld really like to see details on the box with ext2 corruption on SCSI.
> Tigran, IIRC you had it on SCSI boxen, right? Could you send me relevant
> part of logs?
> 

I definitely did have this very corruption on a 4xXeon SCSI-only box. But
the bad news is that I reinstalled redhat7 on it immediately after this
happened so I don't have the logs. _However_, I don't need that particular
root filesystem there anymore (since more disks arrive today and I'm
rearranging stuff) so I'll try and corrupt it for you right now. Using
test12-pre3, unless you have better suggestions on what to do to help.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
