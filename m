Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129325AbQK1A7Q>; Mon, 27 Nov 2000 19:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129477AbQK1A7G>; Mon, 27 Nov 2000 19:59:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28218 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129325AbQK1A7A>; Mon, 27 Nov 2000 19:59:00 -0500
Date: Tue, 28 Nov 2000 01:28:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Michael Meissner <meissner@spectacle-pond.org>,
        "David S. Miller" <davem@redhat.com>, Werner.Almesberger@epfl.ch,
        adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001128012836.B25166@athlon.random>
In-Reply-To: <20001127200618.A19980@athlon.random> <Pine.LNX.3.95.1001127142845.2961A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1001127142845.2961A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Nov 27, 2000 at 02:34:45PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 02:34:45PM -0500, Richard B. Johnson wrote:
> The following shell-script shows that gcc-2.8.1 produces code with
> data allocations adjacent. However, they are reversed!

same with 2.95.* :).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
