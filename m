Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVEGOpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVEGOpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 10:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVEGOpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 10:45:36 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6158 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261348AbVEGOp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 10:45:27 -0400
Date: Sat, 7 May 2005 16:45:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jan Dittmer <jdittmer@ppp0.net>, dhowells@redhat.com,
       uclinux-v850@lsi.nec.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: frv, v850: no defconfig's
Message-ID: <20050507144522.GM3590@stusta.de>
References: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427CC082.4000603@ppp0.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 03:20:02PM +0200, Jan Dittmer wrote:
>...
> - frv: still broken
>   Details: http://l4x.org/k/?d=3479
>...
> - v850: still broken
>   Details: http://l4x.org/k/?d=3497
> 
> Summary: 8 ok, 14 failed
> Link to this page: http://l4x.org/k/?diff[v1]=mm

@ David, Miles:
Could you add defconfig's?

They serve at least two purposes:
- give people a starting point for their kernel configuration
- allow simple cross-compile tests like the one Jan did

A defconfig isn't something special, it's simply one reasonable .config 
for this architecture.

> Jan

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

