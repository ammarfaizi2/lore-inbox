Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136735AbREAVvY>; Tue, 1 May 2001 17:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136736AbREAVvN>; Tue, 1 May 2001 17:51:13 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:54029 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S136735AbREAVu6>;
	Tue, 1 May 2001 17:50:58 -0400
Date: Tue, 1 May 2001 23:50:46 +0200
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: * Re: Severe trashing in 2.4.4
Message-ID: <20010501235046.A23616@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well,

When a puzzled Alexey wondered whether the problems I was seeing with 2.4.4
might be related to a failure to execute 'make clean' before compiling the
kernel, I replied in the negative as I *always* clean up before compiling
anything. Yet, for the sake of science and such I moved the kernel tree and
started from scratch.

The problems I was seeing are no more, 2.4.4 behaves like a good kernel should.

Was it me? Was it reiserfs? Was is divine intervention? I will probably never
find out, but for now this thread, and the accompanying scare, can Resquiam In
Paces.

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
