Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262849AbVCWH65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbVCWH65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVCWH5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:57:20 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:47496 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262853AbVCWHz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:55:27 -0500
Date: Wed, 23 Mar 2005 08:55:25 +0100
From: bert hubert <ahu@ds9a.nl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>,
       "akpm @ osdl. org Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: netdev-2.6 queue updated
Message-ID: <20050323075525.GA25273@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jeff Garzik <jgarzik@pobox.com>, Netdev <netdev@oss.sgi.com>,
	"akpm @ osdl. org Linux Kernel" <linux-kernel@vger.kernel.org>
References: <4240E35C.2090203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4240E35C.2090203@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 10:32:44PM -0500, Jeff Garzik wrote:
> Wireless update, and various minor fixes.
> 
> BK URL, patch URL, and changelog attached.

Jeff, akpm can you predict if this will make 2.6.12? Especially the wireless
& hostap stuff.

>  net/ieee80211/Kconfig                           |   67 
>  net/ieee80211/Makefile                          |   11 
>  net/ieee80211/ieee80211_crypt.c                 |  259 +
>  net/ieee80211/ieee80211_crypt_ccmp.c            |  470 ++
>  net/ieee80211/ieee80211_crypt_tkip.c            |  708 ++++
>  net/ieee80211/ieee80211_crypt_wep.c             |  272 +
>  net/ieee80211/ieee80211_module.c                |  268 +
>  net/ieee80211/ieee80211_rx.c                    | 1206 +++++++
>  net/ieee80211/ieee80211_tx.c                    |  448 ++
>  net/ieee80211/ieee80211_wx.c                    |  471 ++


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
