Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVB1Tfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVB1Tfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 14:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVB1Tfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 14:35:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49414 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261565AbVB1Tfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 14:35:31 -0500
Date: Mon, 28 Feb 2005 20:35:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
Message-ID: <20050228193529.GG4021@stusta.de>
References: <20050228192001.GA14221@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228192001.GA14221@apps.cwi.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries,

your patch has many overlappings with a patch of mine aleady in -mm 
(both none of the two patches is a subset of the other one).

Nowadays, working against -mm often avoids duplicate work.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

