Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271737AbRHUQXb>; Tue, 21 Aug 2001 12:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271739AbRHUQXV>; Tue, 21 Aug 2001 12:23:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1796 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271735AbRHUQXG>; Tue, 21 Aug 2001 12:23:06 -0400
Subject: Re: massive filesystem corruption with 2.4.9
To: cwidmer@iiic.ethz.ch
Date: Tue, 21 Aug 2001 17:26:04 +0100 (BST)
Cc: kristian@korseby.net (Kristian), alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Christian Widmer" at Aug 21, 2001 06:18:52 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZELs-0008EA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that it is a memory problem i also don't belive. that ram work for over 2 year
> with no errors found with memtest (memtset86, intels memtest) compiling
> seveal times xfree86 and an many many times several kernels. 
> 
> and i never had any problems. until i tried the first time a 2.4.x kernel on 
> the fileserver (that was 2.4.6). so i moved the fileserver back to 2.2.19.

Nod. I can follow that reasoning, I've come across boxes that fialed with
2.4 with memory errors, but not 2.2. So far however those have all shown up
with memtest86, or been Athlon optimisation triggered via things

Curiouser and curiouser
