Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWEJFg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWEJFg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 01:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWEJFg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 01:36:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8969 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964795AbWEJFg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 01:36:58 -0400
Date: Wed, 10 May 2006 07:37:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
Message-ID: <20060510053701.GO3570@stusta.de>
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 07:56:04PM -0700, Daniel Walker wrote:

> unsigned long may not always be 32 bits, right ? This patch fixes the 
> warning, but not the bug .
>...

IOW, all your patch does is to hide a bug?

Not exactly an improvement...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

