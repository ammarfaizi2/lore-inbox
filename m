Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSGBNFy>; Tue, 2 Jul 2002 09:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSGBNFx>; Tue, 2 Jul 2002 09:05:53 -0400
Received: from smtp.intrex.net ([209.42.192.250]:2822 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S316774AbSGBNFx>;
	Tue, 2 Jul 2002 09:05:53 -0400
Date: Tue, 2 Jul 2002 09:13:44 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020702091344.A31003@tricia.dyndns.org>
References: <20020702123718.A4711@redhat.com> <Pine.LNX.3.95.1020702075957.24872A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.95.1020702075957.24872A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Tue, Jul 02, 2002 at 08:04:14AM -0400
X-Declude-Sender: jlnance@intrex.net [216.181.42.97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 08:04:14AM -0400, Richard B. Johnson wrote:

> As I am led to understand from reading this thread, there is some
> known bug caused by module removal. Therefore the "solution" is to
> remove module removal capability.
> 
> This is absurd. Next, somebody will remove network capability because
> there's some bug in it.  Hello there........?  Are there any carbon-
> based life-forms out there?

I may be misundersting things, but I dont think anyone is proposing
removing the module unloading capability.  I think what people are
saying is that the bugs are hard to trigger and fixing them introduces
performance problems so its better to tell people not to unload modules.
I dont think anyone is proposing preventing you from ignoring this advise.

I dont know this for sure, so I would love someone to make a definitive
comment.

Thanks,

Jim
