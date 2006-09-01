Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWIAVBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWIAVBo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWIAVBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:01:44 -0400
Received: from mx.pathscale.com ([64.160.42.68]:62851 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750834AbWIAVBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:01:42 -0400
Subject: Re: [openib-general] 2.6.18-rc5-mm1:
	drivers/infiniband/hw/amso1100/c2.c compile error
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Adrian Bunk <bunk@stusta.de>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <adazmdjgvf7.fsf@cisco.com>
References: <20060901015818.42767813.akpm@osdl.org>
	 <20060901160023.GB18276@stusta.de> <20060901101340.962150cb.akpm@osdl.org>
	 <adak64nij8f.fsf@cisco.com> <20060901112312.5ff0dd8d.akpm@osdl.org>
	 <ada8xl3ics4.fsf@cisco.com> <20060901130444.48f19457.akpm@osdl.org>
	 <20060901204343.GA4979@flint.arm.linux.org.uk>  <adazmdjgvf7.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 14:01:41 -0700
Message-Id: <1157144501.20958.12.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 13:54 -0700, Roland Dreier wrote:

> I agree completely.  And going one step further: if an architecture
> cannot implement a 64-bit write atomically, then the precise
> serialization that is required is device-specific knowledge that
> belongs in the device driver.

Absolutely.

	<b


-- 
VGER BF report: H 0
