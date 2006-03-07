Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWCGA0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWCGA0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWCGA0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:26:53 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37803
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932523AbWCGA0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:26:52 -0500
Date: Mon, 06 Mar 2006 16:26:59 -0800 (PST)
Message-Id: <20060306.162659.129097248.davem@davemloft.net>
To: rdreier@cisco.com
Cc: mshefty@ichips.intel.com, sean.hefty@intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 6/6] IB: userspace support for
 RDMA connection manager
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adapskz3zw7.fsf@cisco.com>
References: <adau0ab42ni.fsf@cisco.com>
	<20060306.145053.129802994.davem@davemloft.net>
	<adapskz3zw7.fsf@cisco.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Mar 2006 15:40:56 -0800

> and 32 threads are probably good for flushing out SMP races.

Indeed, guess what I've been spending most of my time working
on lately? :)
