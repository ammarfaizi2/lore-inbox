Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136505AbREGRyE>; Mon, 7 May 2001 13:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136527AbREGRx4>; Mon, 7 May 2001 13:53:56 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:47625 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S136505AbREGRxl>;
	Mon, 7 May 2001 13:53:41 -0400
Date: Mon, 7 May 2001 19:53:33 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: alexander.eichhorn@rz.tu-ilmenau.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
Message-ID: <20010507195333.A13072@se1.cogenit.fr>
In-Reply-To: <E14wlUi-0003WQ-00@the-village.bc.nu> <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, May 07, 2001 at 12:12:57PM -0400
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson <root@chaos.analogic.com> ecrit :
[...]
> when the hardware I/O is used. This shows that the network code, alone,
> cannot be improved very much to provide an improvement in throughput.

It shows that cached code performs well with ~0us latency device/memory.

Networking is about latency and pps too. They both dramatically reduce
the (axe-)evaluated bandwith.

-- 
Ueimor
