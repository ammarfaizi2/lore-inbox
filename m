Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQJaJIA>; Tue, 31 Oct 2000 04:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQJaJHu>; Tue, 31 Oct 2000 04:07:50 -0500
Received: from [62.172.234.2] ([62.172.234.2]:59176 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129413AbQJaJHo>;
	Tue, 31 Oct 2000 04:07:44 -0500
Date: Tue, 31 Oct 2000 09:07:29 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andi Kleen <ak@suse.de>
cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
In-Reply-To: <20001031095410.A25158@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0010310906310.1604-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Andi Kleen wrote:

> On Tue, Oct 31, 2000 at 08:49:02AM +0000, Tigran Aivazian wrote:
> > 
> > what do you mean?! That is, of course, impossible because it would break
> > all existing software, so I won't even bother checking the code, safely 
> > assuming that you perhaps meant something else, ok?
> 
> He refers to faulting into the page table from a master table, not faulting 
> from disk.
> 

Ah, ok then. Thanks Andi, I was a bit worried that the world has changed 
too radically for me to catch up :)

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
