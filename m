Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131738AbQLMUzV>; Wed, 13 Dec 2000 15:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131568AbQLMUzL>; Wed, 13 Dec 2000 15:55:11 -0500
Received: from [212.32.186.211] ([212.32.186.211]:46046 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S131785AbQLMUzB>; Wed, 13 Dec 2000 15:55:01 -0500
Date: Wed, 13 Dec 2000 21:23:52 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
cc: linux-kernel@vger.kernel.org, Alan.Cox@linux.org
Subject: Re: [PATCH] Bug in date converting functions DOS<=>UNIX in FAT,
 NCPFS and SMBFS drivers [second attempt]
In-Reply-To: <Pine.GSO.3.96.SK.1001213154121.6051A-100000@univ.uniyar.ac.ru>
Message-ID: <Pine.LNX.4.21.0012132051570.20073-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Igor Yu. Zhbanov wrote:

> I think your testprogram is broken (or else my testprogram is broken :).

Yes, you were right. Mine must have been broken (possibly caused by
trying to make it readable :). Thanks.

Alan, if you still have the patch please apply it to smbfs in 2.2
(and possibly fat too, I assume it is the same). If you don't I'll send it
again for 2.2.19pre2 or so.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
