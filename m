Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264653AbUESX6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbUESX6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 19:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUESX6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 19:58:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42977 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264653AbUESX6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 19:58:22 -0400
Message-ID: <40ABF490.80901@pobox.com>
Date: Wed, 19 May 2004 19:58:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniele Venzano <webvenza@libero.it>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Dominik Karall <dominik.karall@gmx.net>
Subject: Re: [PATCH] Sis900 bug fixes 3/4
References: <20040518120237.GC23565@picchio.gall.it> <20040518123020.GF23565@picchio.gall.it> <20040519142852.GC798@picchio.gall.it>
In-Reply-To: <20040519142852.GC798@picchio.gall.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano wrote:
> http://teg.homeunix.org/sis900.html
> 
> They are:
> sis900-maintainers

Let's hold off on this for now...  we can commit this patch anytime, and 
there is no harm in being "unofficial maintainer" for a while.


> sis900-isa-bridge-id

applied, with modifications, to netdev-2.6


> sis900-phy-detection (attached below)

I'd like to wait until my netdev-2.6 changes (just pushed to their 
public BK home, bk://gkernel.bkbits.net/netdev-2.6) are pulled by 
Andrew, and incorporated into the update of his -mm tree.

This patch will likely need some rediffing.


> sis900-header-cleanups

applied, with modifications, to netdev-2.6

Also I applied the sis900-detach found on the web page.

	Jeff



