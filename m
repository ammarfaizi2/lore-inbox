Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314596AbSFNWtT>; Fri, 14 Jun 2002 18:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSFNWtT>; Fri, 14 Jun 2002 18:49:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59399 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314596AbSFNWtS>;
	Fri, 14 Jun 2002 18:49:18 -0400
Message-ID: <3D0A7219.6000303@mandrakesoft.com>
Date: Fri, 14 Jun 2002 18:45:45 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] : ir250_cache_wait_data-2.diff
In-Reply-To: <20020610175300.E21783@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch did not apply...  I think you're a victim of __FUNCTION__ 
cleanups, possibly.  Whoever did those in recent 2.5.x kernels didn't 
bother notifying any maintainers :(

