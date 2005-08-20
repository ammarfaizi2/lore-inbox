Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVHTK5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVHTK5F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 06:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbVHTK5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 06:57:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30983 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751239AbVHTK5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 06:57:02 -0400
Date: Sat, 20 Aug 2005 12:56:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 2.6.13-rc6] docs: fix misinformation about overcommit_memory
Message-ID: <20050820105654.GO3615@stusta.de>
References: <200508192318_MC3-1-A7AE-1D7A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508192318_MC3-1-A7AE-1D7A@compuserve.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 11:14:39PM -0400, Chuck Ebbert wrote:

> Someone complained about the docs for vm_overcommit_memory being wrong.
> This patch copies the text from the vm documentation into procfs.
> Please apply.
>...

Do we really need two copies of the same text?

Couldn't you instead write some kind of "please look at 
Documentation/vm/overcommit-accounting"?

> Chuck

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

