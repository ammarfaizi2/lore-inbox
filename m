Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129971AbQKXJVh>; Fri, 24 Nov 2000 04:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132285AbQKXJV2>; Fri, 24 Nov 2000 04:21:28 -0500
Received: from cs.columbia.edu ([128.59.16.20]:24824 "EHLO cs.columbia.edu")
        by vger.kernel.org with ESMTP id <S129971AbQKXJVK>;
        Fri, 24 Nov 2000 04:21:10 -0500
Date: Fri, 24 Nov 2000 00:51:05 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <3A1DFDED.1C37EA7C@haque.net>
Message-ID: <Pine.LNX.4.21.0011240047520.16450-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2000, Mohammad A. Haque wrote:

> Yep. Unless of course they are SCSI with an identity crisis =P

Ok. Are there any IDE-related errors in your logs prior to getting the f/s
corruption? They could be relevant no matter how much time passed between
them and the first signs of corruption.

Are your drives running with UDMA transfers enabled?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
