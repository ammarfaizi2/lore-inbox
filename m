Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGXjm>; Wed, 7 Feb 2001 18:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBGXjd>; Wed, 7 Feb 2001 18:39:33 -0500
Received: from fungus.teststation.com ([212.32.186.211]:57562 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129027AbRBGXjX>; Wed, 7 Feb 2001 18:39:23 -0500
Date: Thu, 8 Feb 2001 00:39:16 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: <JShaw@jbwere.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and oops on 'mount -t smbfs'
In-Reply-To: <974A613A43EED311ACBD00508B5EF8C1D66DEF@meexc04.jbwere.com.au>
Message-ID: <Pine.LNX.4.30.0102080036110.4033-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001 JShaw@jbwere.com.au wrote:

> I've compiled a number of 2.4.1 and 2.4.0 kernels (actually supports the 4GB
> RAM!!!  Yay!!!!), and I have only one more problem to sort out.  Under
> 2.4.x, the mount completes successfully, but 'ls /net' causes an OOPS: 0000.

Try http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.1-pre10-cache-2.patch

Let me know if it works for you or not.
(patch should be ok with 2.4.0 or 2.4.1)

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
