Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129499AbRBBQqY>; Fri, 2 Feb 2001 11:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129536AbRBBQqO>; Fri, 2 Feb 2001 11:46:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16391 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129499AbRBBQqF>; Fri, 2 Feb 2001 11:46:05 -0500
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
To: kas@informatics.muni.cz (Jan Kasprzak)
Date: Fri, 2 Feb 2001 16:46:45 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), reiser@namesys.com (Hans Reiser),
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <20010202173644.A12520@informatics.muni.cz> from "Jan Kasprzak" at Feb 02, 2001 05:36:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OjME-0006nU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> : 	It is the original one. I'll try with the -69:
> : 
> 	With 2.96-69 the reiserfs seems to work well.
> Sorry for the confusion, I forgot to upgrade the gcc on my machine.

Excellent. Im just glad to know its a fixed bug.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
