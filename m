Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265059AbSK1BkG>; Wed, 27 Nov 2002 20:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbSK1BkG>; Wed, 27 Nov 2002 20:40:06 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:63628 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S265059AbSK1BkF>;
	Wed, 27 Nov 2002 20:40:05 -0500
Date: Wed, 27 Nov 2002 20:49:17 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: alan@lxorguk.ukuu.org.uk, greg@kroah.com, perex@suse.cz,
       zwane@holomorphy.com, kronos@kronoz.cjb.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Card Services - 2.5.49
Message-ID: <20021127204917.GE30284@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, alan@lxorguk.ukuu.org.uk,
	greg@kroah.com, perex@suse.cz, zwane@holomorphy.com,
	kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
References: <20021127194950.GD30284@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021127194950.GD30284@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch should apply against 2.5.50 as well, considering only a couple pnp changes
> were made by Alan.  If it doesn't, please let me know.
> 

Actually that's not entirely correct.  It will apply against the latest pnp bk tree at
bk://linuxusb.bkbits.net/pnp-2.5.  This is because the last set of pnp changes have not
yet been included in the main tree.

Thanks,
Adam
