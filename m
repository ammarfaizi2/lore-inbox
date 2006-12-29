Return-Path: <linux-kernel-owner+w=401wt.eu-S1753015AbWL2M61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbWL2M61 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbWL2M60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:58:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2650 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752752AbWL2M60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:58:26 -0500
Date: Fri, 29 Dec 2006 13:58:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Miller <davem@davemloft.net>
Cc: vonbrand@inf.utfsm.cl, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061229125828.GR20714@stusta.de>
References: <bunk@stusta.de> <200612290136.kBT1a2sO006708@laptop13.inf.utfsm.cl> <20061228.205106.130845178.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228.205106.130845178.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 08:51:06PM -0800, David Miller wrote:
> From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
> Date: Thu, 28 Dec 2006 22:36:02 -0300
> 
> > Adrian Bunk <bunk@stusta.de> wrote:
> > > This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19.
> > 
> > Add that on SPARC64 boot fails due to missing /dev/root. Vanilla 2.6.19 and
> > 2.6.19.1 work fine, before 2.6.20-rc1 it broke. I checked the initrds for
> > both versions, the only difference "diff -Nur" finds between the unpacked
> > initrds are the modules themselves (obviously).
> 
> Did you report this will all relevant details on sparclinux@vger
> so that the sparc64 maintainers can analyze the problem?
> 
> I didn't see the report there else I would be looking into it.
>...

I did copy the email to both sparclinux and you when I asked Horst 
whether it's still present in the latest kernel, and therefore his 
answer that it does the day before yesterday should have reached you.

The thread is "Re: 2.6.19 (current from git) on SPARC64: Can't mount /".

Is there anything I can improve to catch your intention?
Is "reply with fullquote + question + adding Cc's" somehow suboptimal?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

