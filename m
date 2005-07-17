Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVGQWxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVGQWxt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 18:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVGQWxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 18:53:48 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40720 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261438AbVGQWxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 18:53:47 -0400
Date: Mon, 18 Jul 2005 00:53:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/bluetooth/: cleanups
Message-ID: <20050717225345.GI3753@stusta.de>
References: <20050717145709.GI3613@stusta.de> <1121615883.22662.38.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121615883.22662.38.camel@pegasus>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2005 at 05:58:03PM +0200, Marcel Holtmann wrote:
> Hi Adrian,
> 
> > This patch contains the following cleanups:
> > - remove BT_DMP/bt_dump
> > - remove the following unneeded EXPORT_SYMBOL's:
> >   - hci_core.c: hci_dev_get
> >   - hci_core.c: hci_send_cmd
> >   - hci_event.c: hci_si_event
> 
> is this the same patch you sent me last time? I still have one of your
> cleanup patches in my queue. I simply was to lazy to get them back into
> mainline.

No problem.

This is the same patch.

Since I didn't hear any answer from you I resended it.
Now I do know that you took it.

> Regards
> 
> Marcel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

