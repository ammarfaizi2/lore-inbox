Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279809AbRJ0Lur>; Sat, 27 Oct 2001 07:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279811AbRJ0Lug>; Sat, 27 Oct 2001 07:50:36 -0400
Received: from cmb1-3.dial-up.arnes.si ([194.249.32.3]:2176 "EHLO
	cmb1-3.dial-up.arnes.si") by vger.kernel.org with ESMTP
	id <S279809AbRJ0Lu2>; Sat, 27 Oct 2001 07:50:28 -0400
From: Igor Mozetic <igor.mozetic@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15322.40861.219484.74719@cmb1-3.dial-up.arnes.si>
Date: Sat, 27 Oct 2001 13:50:53 +0200
To: Mike Galbraith <mikeg@wen-online.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Any stable 2.4 kernel?
In-Reply-To: <Pine.LNX.4.33.0110271212070.446-100000@mikeg.weiden.de>
In-Reply-To: <15322.33513.293148.371409@cmb1-3.dial-up.arnes.si>
	<Pine.LNX.4.33.0110271212070.446-100000@mikeg.weiden.de>
X-Mailer: VM 6.96 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

 > (I'm still running 2.4.3 in this box's 'vital functions' environment)

Nice to hear this - what are your uptimes for 2.4.3 and load?
Do you have similar hardware? I have a feeling that highmem
(2GB ram) is the most critical part kernel-wise since the
rest of our machines ('normal', 128-768MB ram) was very solid
under 2.4.3 and 2.4.9 kernels (but they are not so loaded).

Regards,
        Igor
