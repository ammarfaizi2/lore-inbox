Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbQLVU7c>; Fri, 22 Dec 2000 15:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130458AbQLVU7W>; Fri, 22 Dec 2000 15:59:22 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:50436 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130073AbQLVU7N>; Fri, 22 Dec 2000 15:59:13 -0500
Subject: Re: NUMA and SCI [was Re: bigphysarea support in 2.2.19 and 2.4.0 kernels]
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Fri, 22 Dec 2000 20:30:07 +0000 (GMT)
Cc: middelin@polyware.nl (Pauline Middelink), linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
In-Reply-To: <20001222133908.A1686@vger.timpanogas.org> from "Jeff V. Merkey" at Dec 22, 2000 01:39:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E149YpM-0005A2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think we do need some bettr APIs.  Grab the source at my FTP server,
> and I'd love any input you could provide.

Pure message passing drivers for the Dolphinics cards already exist. Ron
Minnich wrote some.

http://www.acl.lanl.gov/~rminnich/

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
