Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268142AbUHKSPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268142AbUHKSPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268154AbUHKSPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:15:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42414 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268142AbUHKSOv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 14:14:51 -0400
Message-ID: <411A620C.30504@pobox.com>
Date: Wed, 11 Aug 2004 14:14:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Wireless Extension v17 for Linus
References: <20040811181030.GA23701@bougret.hpl.hp.com>
In-Reply-To: <20040811181030.GA23701@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	Hi Jeff,
> 
> 	New improved version of my previous patch :
> http://marc.theaimsgroup.com/?l=linux-netdev&m=109158012711737&w=2
> 
> 	When you think it's over, you always end up receiving new
> feedback. This version only fixes a few comments and remove some
> useless and potentially confusing consts. No code change to previous
> version.
> 	By the way, I would not mind a ack that you have properly
> received this patch (and the driver patch) and that they are queued
> for Linus...


It looks OK, but I am going to wait to commit it until after 2.6.8 is 
released.  I need that time to recover from a hard drive disaster, which 
lost some useful details in the netdev-2.6 queue (but the queue itself 
is still fine, being mirrored in several locations).

	Jeff


