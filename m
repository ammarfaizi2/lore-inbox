Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAICKB>; Mon, 8 Jan 2001 21:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129706AbRAICJv>; Mon, 8 Jan 2001 21:09:51 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:27147 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129226AbRAICJi>; Mon, 8 Jan 2001 21:09:38 -0500
Date: Mon, 8 Jan 2001 22:18:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Evans <chris@scary.beasts.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2 vs. 2.4 benchmarks
In-Reply-To: <Pine.LNX.4.30.0101090000110.9761-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.21.0101082202370.6280-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Chris Evans wrote:

> I did one other quick test, with disappointing results for 2.4.0. I did a
> kernel build with 32Mb.
> 
> 2.4.0 was taking about 10 mins to do the build. 2.2.x was 1min30 quicker
> :( I was hoping/expecting the 2.4.0 page aging to do better, due to
> keeping the more useful pages in RAM better. I have no explanation.

The swap device was used how much during the compilation ? 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
