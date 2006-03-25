Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWCYRhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWCYRhm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWCYRhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:37:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32527 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751454AbWCYRhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:37:41 -0500
Date: Sat, 25 Mar 2006 18:37:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-usb-devel@lists.sourceforge.ne, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] usb/input/keyspan_remote.c: don't use an uninitialized variable
Message-ID: <20060325173740.GI4053@stusta.de>
References: <20060325171214.GG4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325171214.GG4053@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 06:12:14PM +0100, Adrian Bunk wrote:
>...
> Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>
>...

Cut'n'paste error of the year...

Darren Jenkins was in no way involved with this patch, this should have 
been:

Signed-off-by: Adrian Bunk <bunk@stusta.de>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

