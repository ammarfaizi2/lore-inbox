Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129941AbQKQA4c>; Thu, 16 Nov 2000 19:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbQKQA4W>; Thu, 16 Nov 2000 19:56:22 -0500
Received: from hera.cwi.nl ([192.16.191.1]:6343 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129941AbQKQA4J>;
	Thu, 16 Nov 2000 19:56:09 -0500
Date: Fri, 17 Nov 2000 01:26:02 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011170026.BAA133349.aeb@aak.cwi.nl>
To: aeb@veritas.com, torvalds@transmeta.com
Subject: Re: BUG: isofs broken (2.2 and 2.4)
Cc: emoenke@gwdg.de, eric@andante.org, koenig@tat.physik.uni-tuebingen.de,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> both 2.2.x and 2.4.x kernels can't read `real sky' CDs

Yes. 2.0.38 is OK. I just made a patch that seems to work.

Harald, could you try
	ftp.xx.kernel.org/.../people/aeb/linux-2.4.0test9-isofs-patch
and report?

Linus, Alan - I made patches for 2.2 and 2.4 but want to
polish and check them a bit more before submitting.
There also seem to be a lot of bug reports in newsgroups
and mailing lists - must check whether people complain
about the same thing or whether there are more problems.

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
