Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbULHV6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbULHV6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 16:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbULHV6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 16:58:30 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:14277 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261380AbULHV6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 16:58:23 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [2.4 patch] USB_ETH{,_RNDIS} EXPERIMENTAL dependencies
Date: Wed, 8 Dec 2004 13:57:13 -0800
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, Mike Castle <dalgoda@ix.netcom.com>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, zaitcev@redhat.com
References: <20041205165908.GA25139@thune.sonic.net> <20041208025248.GN5496@stusta.de> <20041208030238.GO5496@stusta.de>
In-Reply-To: <20041208030238.GO5496@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412081357.13910.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 December 2004 7:02 pm, Adrian Bunk wrote:
> Mike Castle <dalgoda@ix.netcom.com> noted that USB_ETH and USB_ETH_RNDIS 
> in 2.4 are marked as "(EXPERIMENTAL)", but don't depend on EXPERIMENTAL.
> 
> 
> The patch below removes the "(EXPERIMENTAL)" string from USB_ETH and 
> lets USB_ETH_RNDIS depend on EXPERIMENTAL.
> 
> This is similar to the dependencies 2.6 .

Looks fine to me; go for it!
