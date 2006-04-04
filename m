Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWDDQCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWDDQCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWDDQCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:02:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45325 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750728AbWDDQCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:02:25 -0400
Date: Tue, 4 Apr 2006 18:02:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-mm1: drivers/w1/: patch undoes reasonable cleanups
Message-ID: <20060404160223.GG6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.16-mm2:
>...
> +gregkh-i2c-w1-userspace-communication-protocol-over-connector.patch
>...
>  I2C tree.
>...

Evgeniy Polyakov did ACK my patch 
a9fb1c7b950bed4afe208c9d67e20f086bb6abbb, and I'm therefore really 
pissed off seeing him silently reverting it for no good reason as part 
of this patch.

Greg, please drop this patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

