Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129985AbQK3R4o>; Thu, 30 Nov 2000 12:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130563AbQK3R4X>; Thu, 30 Nov 2000 12:56:23 -0500
Received: from 194-73-188-62.btconnect.com ([194.73.188.62]:38159 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129912AbQK3Rrd>;
        Thu, 30 Nov 2000 12:47:33 -0500
Date: Thu, 30 Nov 2000 17:19:05 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "John B. Jacobsen" <jbj_ss@mail.tele.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Pls add this driver to the kernel tree !!
In-Reply-To: <200011280251.eAS2p2S15351@localhost.jbj.dk>
Message-ID: <Pine.LNX.4.21.0011301715550.847-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Dick,

On Tue, 28 Nov 2000, John B. Jacobsen wrote:
> /* Set the copy breakpoint for the copy-only-tiny-frames scheme.
>    Setting to > 1518 effectively disables this feature. */
> static int rx_copybreak = 0;

A skeleton driver has a higher responsibility than just "a driver" and
thus needs to be ideal. The above line makes it less so than it would have
been without it.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
