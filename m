Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129193AbRBTBYt>; Mon, 19 Feb 2001 20:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBTBYj>; Mon, 19 Feb 2001 20:24:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51717 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129193AbRBTBY2>; Mon, 19 Feb 2001 20:24:28 -0500
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
To: neilb@cse.unsw.edu.au (Neil Brown)
Date: Tue, 20 Feb 2001 01:24:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dek_ml@konerding.com,
        linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
        mason@suse.com
In-Reply-To: <14993.48376.203279.390285@notabene.cse.unsw.edu.au> from "Neil Brown" at Feb 20, 2001 11:40:24 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14V1Xa-0005Bf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  This may seem like a lot, but several of these are already
>  requirements which most filesystems don't meet, and other are there
>  to tidy-up interfaces and make locking more straight forward.

As a 2.5 thing it sounds like a very sensible path. It will also provide
some of the operations groundwork needed for file systems that can only use
NFS4 temporary handles

