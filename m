Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbULSQIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbULSQIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 11:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULSQIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 11:08:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6929 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261304AbULSQIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 11:08:02 -0500
Date: Sun, 19 Dec 2004 17:07:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Network Development Mailing List <netdev@oss.sgi.com>
Subject: Re: [2.6 patch] net/bluetooth/: misc possible cleanups
Message-ID: <20041219160758.GY21288@stusta.de>
References: <20041214041352.GZ23151@stusta.de> <1103009649.2143.65.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103009649.2143.65.camel@pegasus>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 08:34:08AM +0100, Marcel Holtmann wrote:

> Hi Adrian,

Hi Marcel,

>...
> > Please comment on which of these changes are correct and which conflict 
> > with pending patches.
> 
> Please send a separate patch for all the RFCOMM changes, because these
> conflicts with some pending patches and then it will make it easier for
> me to merge them.
> 
> The rest of the changes are fine with me, but I like to see also a
> separate patch for the CMTP stuff and cmtp_send_capimsg() don't need a
> forward declaration. Simply move the function to another place in the
> source code.

splitted patches follow as reply to this email.

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

