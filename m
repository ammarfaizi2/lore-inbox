Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVFTSpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVFTSpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbVFTSpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:45:53 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14347 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261438AbVFTSpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:45:43 -0400
Date: Mon, 20 Jun 2005 20:45:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Petter =?iso-8859-1?Q?Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Observation: very low USB performance in 2.6.12 (-2 from agnula)
Message-ID: <20050620184539.GC3666@stusta.de>
References: <42B7075C.1090606@findus.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42B7075C.1090606@findus.dhs.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 08:13:48PM +0200, Petter Sundlöf wrote:

> I've observed that USB performance (mass storage) is severaly degraded 
> in 2.6.12. Going back to 2.6.10 restores performances to expected levels.

Is CONFIG_BLK_DEV_UB enabled in your kernel?
If yes, does disabling it fix the problem?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

