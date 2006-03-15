Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752175AbWCOXkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbWCOXkw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbWCOXkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:40:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8887
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752171AbWCOXkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:40:51 -0500
Date: Wed, 15 Mar 2006 15:40:46 -0800 (PST)
Message-Id: <20060315.154046.130190626.davem@davemloft.net>
To: jesse.brandeburg@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org,
       cramerj@intel.com, john.ronciak@intel.com, jesse.brandeburg@intel.com
Subject: Re: [PATCH]: e1000 endianness bugs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4807377b0603151533i6a693d99ycdab71fe0a21dc4c@mail.gmail.com>
References: <20060315.142628.28661597.davem@davemloft.net>
	<4807377b0603151533i6a693d99ycdab71fe0a21dc4c@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Date: Wed, 15 Mar 2006 15:33:43 -0800

> Yep, those look like bugs to me, thanks and congratulations, you're
> the first person to test our PCI Express adapters in a big endian
> system (they haven't been available before, and we don't have one,
> yet)

It was onboard a Niagara T2000 system.
