Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264432AbRFOPxA>; Fri, 15 Jun 2001 11:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264430AbRFOPwu>; Fri, 15 Jun 2001 11:52:50 -0400
Received: from mean.netppl.fi ([195.242.208.16]:64007 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S264429AbRFOPwh>;
	Fri, 15 Jun 2001 11:52:37 -0400
Date: Fri, 15 Jun 2001 18:52:35 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
Message-ID: <20010615185235.A29313@netppl.fi>
In-Reply-To: <15145.11935.992736.767777@pizda.ninka.net> <Pine.LNX.4.21.0106141739140.16013-100000@ns> <15145.12192.199302.981306@pizda.ninka.net> <20010615111213.C2245@osc.edu> <15146.11179.315190.615024@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <15146.11179.315190.615024@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 08:37:15AM -0700, David S. Miller wrote:
> 
> Pete Wyckoff writes:
>  > We're currently working on using both processors
>  > of the Tigon in parallel.
> 
> It is my understanding that on the Tigon2, the second processor is
> only for working around hw bugs in the DMA controller of the board and
> cannot be used for other tasks.
> 
> WRT. tigon3, it was mentioned on this list that it is a pair of arm9
> cpus, one for rx and one for tx.
> 
Might be worth asking broadcom instead of 3com for the specs, 
as they seem to be selling it as a chip (BCM5700/5701), whereas 3com sells a
board (3c996).

-- 
Pekka Pietikainen



