Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129937AbQK2BI3>; Tue, 28 Nov 2000 20:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129882AbQK2BIT>; Tue, 28 Nov 2000 20:08:19 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:58648 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129937AbQK2BID>; Tue, 28 Nov 2000 20:08:03 -0500
Date: Wed, 29 Nov 2000 01:38:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre19 oops in try_to_free_pages
Message-ID: <20001129013801.A20971@athlon.random>
In-Reply-To: <20001128134418.C54301@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001128134418.C54301@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Tue, Nov 28, 2000 at 01:44:18PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 01:44:18PM +0200, Ville Herva wrote:
> try Andrea's vm-global-7 now. It seems to include the bits Rik posted, or

It doesn't include the bits Rik posted because they were unnecessary.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
