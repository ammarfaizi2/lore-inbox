Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129392AbQLGLXu>; Thu, 7 Dec 2000 06:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQLGLXl>; Thu, 7 Dec 2000 06:23:41 -0500
Received: from [62.172.234.2] ([62.172.234.2]:34771 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129392AbQLGLXW>;
	Thu, 7 Dec 2000 06:23:22 -0500
Date: Thu, 7 Dec 2000 10:53:33 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.LNX.4.21.0012071007420.970-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012071052250.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Tigran Aivazian wrote:
> a) we don't hit that test because permission takes care of it (for
> regulars/dirs/symlinks but here only regulars are important)

omit what is in brackets but everything in email and the patch itself are
valid and tested. The detail in bracket above was unimportant since the
main text provided enough proof.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
