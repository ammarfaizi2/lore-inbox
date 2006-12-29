Return-Path: <linux-kernel-owner+w=401wt.eu-S1752733AbWL2MxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbWL2MxH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbWL2MxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:53:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2633 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752733AbWL2MxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:53:05 -0500
Date: Fri, 29 Dec 2006 13:53:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061229125307.GQ20714@stusta.de>
References: <20061228223909.GK20714@stusta.de> <200612290136.kBT1a2sO006708@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612290136.kBT1a2sO006708@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 10:36:02PM -0300, Horst H. von Brand wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> > This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19.
> 
> Add that on SPARC64 boot fails due to missing /dev/root. Vanilla 2.6.19 and
> 2.6.19.1 work fine, before 2.6.20-rc1 it broke. I checked the initrds for
> both versions, the only difference "diff -Nur" finds between the unpacked
> initrds are the modules themselves (obviously).

Sorry, I knew about this and somehow forgot to add it to my list.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

