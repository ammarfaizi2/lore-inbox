Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276630AbRI2VUv>; Sat, 29 Sep 2001 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276633AbRI2VUl>; Sat, 29 Sep 2001 17:20:41 -0400
Received: from www.fagotten.org ([212.73.164.10]:26628 "EHLO
	joxer.fagotten.org") by vger.kernel.org with ESMTP
	id <S276630AbRI2VUX>; Sat, 29 Sep 2001 17:20:23 -0400
Message-ID: <3BB63B20.4E69B51D@fagotten.org>
Date: Sat, 29 Sep 2001 23:20:32 +0200
From: Daniel Elvin <daniel.elvin@fagotten.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.17-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AST P/75 causes Machine Check Exception type 0x9 on v2.4.10
In-Reply-To: <E15nOrR-0002d1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Booting an AST Bravo P/75 with kernel v2.4.10 results in a "CPU#0
> > Machine Check Exception: 0x10C938 (type: 0x9)".
> 
> Please try 2.4.9ac17 - it should be fixed in the -ac tree, and if so I can
> push it on to Linus

That solved the problem. Thanks!

/Daniel
