Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbQKHRhj>; Wed, 8 Nov 2000 12:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQKHRha>; Wed, 8 Nov 2000 12:37:30 -0500
Received: from [207.1.200.39] ([207.1.200.39]:59150 "EHLO
	ded-tscs.innovsoftd.com") by vger.kernel.org with ESMTP
	id <S129113AbQKHRhM>; Wed, 8 Nov 2000 12:37:12 -0500
Date: Wed, 8 Nov 2000 11:38:00 -0600 (CST)
From: "Gregory S. Youngblood" <greg@tcscs.com>
Reply-To: greg@tcscs.com
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with grow_inodes: inode-max limit reached
In-Reply-To: <m3em0nx7sk.fsf@matrix.mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0011081137060.17255-100000@ded-tscs.innovsoftd.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Nov 2000, Chmouel Boudjnah wrote:

> "Gregory S. Youngblood" <greg@tcscs.com> writes:
> 
> > The problem occurs with Mandrake 7.0 and 7.1 with kernels 2.2.14, 2.2.16,
> > and 2.2.17. These are the secure kernels that Mandrake provides.
> 
> can you try with a 2.2.17 kernel rpm standard (no smp no secure) ?

I rebooted with the 'failsafe' kernel, which is 2.2.17 no smp no secure
per your request. If the pattern holds, I will have an update with a
failure (if it fails) within the next 24 to 72 hours.

Thanks,
greg

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
