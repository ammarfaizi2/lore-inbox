Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbVLMWqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbVLMWqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVLMWqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:46:48 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22192
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030286AbVLMWqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:46:47 -0500
Date: Tue, 13 Dec 2005 14:47:13 -0800 (PST)
Message-Id: <20051213.144713.35593177.davem@davemloft.net>
To: weinberg@kestrel.astro.umass.edu
Cc: linux-kernel@vger.kernel.org, weinberg@astro.umass.edu
Subject: Re: 2.6.15-rc5 makes tons of: <NULL>: hw csum failure
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <E1EmIk7-0004Ua-00@kestrel.astro.umass.edu>
References: <E1EmIk7-0004Ua-00@kestrel.astro.umass.edu>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin D. Weinberg" <weinberg@kestrel.astro.umass.edu>
Date: Tue, 13 Dec 2005 17:35:31 -0500

> 1. Kernel errors as follows: <NULL>: hw csum failure, seemingly from the
>    sk98lin module

This has been fixed by Stephen Hemminger already.
