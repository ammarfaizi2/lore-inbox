Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWFTLpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWFTLpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWFTLpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:45:22 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:46603 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1030212AbWFTLpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:45:21 -0400
Date: Tue, 20 Jun 2006 21:46:13 +1000
From: CaT <cat@zip.com.au>
To: Heinz Mauelshagen <mauelshagen@redhat.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: 2.6.16.20/dm: can't create more then one snapshot of an lv
Message-ID: <20060620114613.GZ2059@zip.com.au>
References: <20060619020040.GX2059@zip.com.au> <20060620005405.GY2059@zip.com.au> <20060620100209.GA4566@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620100209.GA4566@redhat.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 12:02:09PM +0200, Heinz Mauelshagen wrote:
> How many snapshots active at once ?

1. I can start more then 1 premade snapshots just fine and use them
but the moment I add another one a freeze occurs.

> I guess this is a kcopyd scalability issue which needs addressing.

Well in the end I'm hoping to get at least 7. Hopefully that's not
insane. :)

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
