Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136657AbREARA5>; Tue, 1 May 2001 13:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136661AbREARAs>; Tue, 1 May 2001 13:00:48 -0400
Received: from cmailg6.svr.pol.co.uk ([195.92.195.176]:47394 "EHLO
	cmailg6.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S136657AbREARAn>; Tue, 1 May 2001 13:00:43 -0400
Date: Tue, 1 May 2001 18:03:40 +0100 (BST)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
Message-ID: <Pine.LNX.4.33.0105011801380.2060-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> is exhibiting weird behavior under K7 optimizations. The jist of my
> research is that compiling a kernel for ANY CPU with the Athlon MMX
> optimization
> *AND* 3DNOW results in massive amounts of oops'es and total system
> instability. The following is what I've tried:

With:

Athlon 700
Asus K7V (KX133 based)

I have been running Athlon based kernels for months, no problems (well,
none like you mention).

gcc 2.96-81 BTW



