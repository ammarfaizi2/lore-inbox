Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278665AbRJXRI6>; Wed, 24 Oct 2001 13:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278666AbRJXRIs>; Wed, 24 Oct 2001 13:08:48 -0400
Received: from [200.248.92.2] ([200.248.92.2]:43276 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S278665AbRJXRIf>; Wed, 24 Oct 2001 13:08:35 -0400
Message-Id: <200110241805.QAA27995@inter.lojasrenner.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.13 high SWAP
Date: Wed, 24 Oct 2001 15:05:52 -0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0110232249090.1185-100000@penguin.transmeta.com> <20011024114026.A14078@outpost.ds9a.nl> <9r6rho$82c$1@penguin.transmeta.com>
In-Reply-To: <9r6rho$82c$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing 2.4.13, and something  is wrong.....


Them machine for test is a DELL 8450 4xPIII 4 GBram, running 4 setiathome, 5 
cp on tmpfs and 1 cpio.

After minutes running the machine eat all my swap area. like "top" sample 
bellow :
Mem:  4118212K av, 3693728K used,  424484K free,       0K shrd,     956K buff
                    615928K actv,       0K in_d,       0K in_c,       0Ktarget
Swap: 1048568K av,  957456K used,   91112K free                 2420888Kcached

I'm using highmem.


Some kernel tunning to adjust that?


Thank's


Andre
