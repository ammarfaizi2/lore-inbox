Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129430AbQJZRw3>; Thu, 26 Oct 2000 13:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129701AbQJZRwT>; Thu, 26 Oct 2000 13:52:19 -0400
Received: from kanga.kvack.org ([209.82.47.3]:39180 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129430AbQJZRwL>;
	Thu, 26 Oct 2000 13:52:11 -0400
Date: Thu, 26 Oct 2000 13:50:52 -0400 (EDT)
From: <kernel@kvack.org>
To: Robert Lynch <rmlynch@best.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops while running test10-pre5
In-Reply-To: <39F84D21.43FB2371@best.com>
Message-ID: <Pine.LNX.3.96.1001026134947.18810C-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2000, Robert Lynch wrote:

> Oct 19 13:00:23 ives kernel: EIP:    0010:[try_to_swap_out+252/796]

Those Oopsen look like they're from test10-pre4 (fixed in pre5).  Also,
please include the lines beginning with "kernel BUG at...".

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
