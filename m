Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWCWISG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWCWISG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWCWISG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:18:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36818
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030202AbWCWISE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:18:04 -0500
Date: Thu, 23 Mar 2006 00:17:25 -0800 (PST)
Message-Id: <20060323.001725.98089946.davem@davemloft.net>
To: sfr@canb.auug.org.au
Cc: miles@gnu.org, miles.bader@necel.com, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] create struct compat_timex and use it everywhere
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060323174719.6d4387ff.sfr@canb.auug.org.au>
References: <20060323164623.699f569e.sfr@canb.auug.org.au>
	<buofyl9llau.fsf@dhapc248.dev.necel.com>
	<20060323174719.6d4387ff.sfr@canb.auug.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 23 Mar 2006 17:47:19 +1100

> On Thu, 23 Mar 2006 15:36:25 +0900 Miles Bader <miles.bader@necel.com> wrote:
> >
> > BTW, why not keep use the parisc version of the structure for the common
> > version, as it has comments for each field (not world breaking, but a
> > nice little thing)?
> 
> I figured if you wanted to understand the structure, you could look at the
> real struct timex.

Agreed.

I'm fine with these timex compat patches.
