Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129371AbQJaIyc>; Tue, 31 Oct 2000 03:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129783AbQJaIyX>; Tue, 31 Oct 2000 03:54:23 -0500
Received: from Cantor.suse.de ([194.112.123.193]:17161 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129371AbQJaIyM>;
	Tue, 31 Oct 2000 03:54:12 -0500
Date: Tue, 31 Oct 2000 09:54:10 +0100
From: Andi Kleen <ak@suse.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
Message-ID: <20001031095410.A25158@gruyere.muc.suse.de>
In-Reply-To: <39FE6291.FA8162A7@didntduck.org> <Pine.LNX.4.21.0010310846490.1494-100000@saturn.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010310846490.1494-100000@saturn.homenet>; from tigran@veritas.com on Tue, Oct 31, 2000 at 08:49:02AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 08:49:02AM +0000, Tigran Aivazian wrote:
> 
> what do you mean?! That is, of course, impossible because it would break
> all existing software, so I won't even bother checking the code, safely 
> assuming that you perhaps meant something else, ok?

He refers to faulting into the page table from a master table, not faulting 
from disk.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
