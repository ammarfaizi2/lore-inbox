Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269237AbRHLScH>; Sun, 12 Aug 2001 14:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269238AbRHLSb5>; Sun, 12 Aug 2001 14:31:57 -0400
Received: from leng.mclure.org ([64.81.48.142]:21001 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S269237AbRHLSbq>; Sun, 12 Aug 2001 14:31:46 -0400
Date: Sun, 12 Aug 2001 11:31:42 -0700
From: Manuel McLure <manuel@mclure.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
Message-ID: <20010812113142.G948@ulthar.internal.mclure.org>
In-Reply-To: <997611819.29909.25.camel@DESK-2> <E15VtzC-0005e6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15VtzC-0005e6-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Aug 12, 2001 at 05:04:54 -0700
X-Mailer: Balsa 1.2.pre1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.08.12 05:04 Alan Cox wrote:
> The in kernel one seemed fine. The 2.4.8 update one is definitely broken
> on
> SMP boxes

I'm getting 2.4.8 Oopsen that seem to be in emu10k1 code on UP - see my
message "2.4.8 oops in ksoftirqd_CPU0"...

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft
