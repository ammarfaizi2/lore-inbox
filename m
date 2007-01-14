Return-Path: <linux-kernel-owner+w=401wt.eu-S1751142AbXANHnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbXANHnt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbXANHnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:43:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1679 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751142AbXANHns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:43:48 -0500
Date: Sun, 14 Jan 2007 08:43:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.20-rc5
Message-ID: <20070114074350.GR7469@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org> <20070112142645.29a7ebe3.akpm@osdl.org> <20070113050143.GF7469@stusta.de> <Pine.LNX.4.61.0701131402000.19787@yvahk01.tjqt.qr> <b6a2187b0701132338t6840551coe83b83d461723198@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0701132338t6840551coe83b83d461723198@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 03:38:24PM +0800, Jeff Chua wrote:
> On 1/13/07, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >On Jan 13 2007 06:01, Adrian Bunk wrote:
> >>On Fri, Jan 12, 2007 at 02:26:45PM -0800, Andrew Morton wrote:
> 
> >*cough*vmware*cough*
> 
> setting CONFIG_PARAVIRT=y will return in ...
> 
>       vmmon.ko module unknown symbol paravirt_ops
> 
> Without it, vmware runs run. Any fix?

Please send the 2.6.20-rc5 .config you saw this with.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

