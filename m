Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSH0IKE>; Tue, 27 Aug 2002 04:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSH0IKE>; Tue, 27 Aug 2002 04:10:04 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:15834 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S315440AbSH0IKD>;
	Tue, 27 Aug 2002 04:10:03 -0400
Date: Tue, 27 Aug 2002 10:13:51 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Andre Hedrick <andre@linux-ide.org>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: IDE success with 2.4.20-pre4-ac1
Message-ID: <20020827101351.A15332@fafner.intra.cogenit.fr>
References: <20020826225747.A14739@fafner.intra.cogenit.fr> <Pine.LNX.4.10.10208262140260.24156-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10208262140260.24156-100000@master.linux-ide.org>; from andre@linux-ide.org on Mon, Aug 26, 2002 at 09:44:06PM -0700
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick <andre@linux-ide.org> :
[...]
> Now to make it so you do not have to pass every darn parameter under the
> sun to get it to go!  That is one of the worst append line I have ever
> seen, I am shocked it took such a big hammer.

The dma options used to give the best results so far. 2.4.20-pre4-ac1 was 
simply tested under the same conditions as the preceedings kernels (and these 
where never able to give more than reliable udma0 on hdg). I'll remove the dma 
options once there's nobody behind it (today).

-- 
Ueimor
