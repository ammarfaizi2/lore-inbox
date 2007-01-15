Return-Path: <linux-kernel-owner+w=401wt.eu-S1751816AbXAOFaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXAOFaJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 00:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751817AbXAOFaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 00:30:09 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49299
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751816AbXAOFaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 00:30:08 -0500
Date: Sun, 14 Jan 2007 21:30:08 -0800 (PST)
Message-Id: <20070114.213008.74745274.davem@davemloft.net>
To: dlstevens@us.ibm.com
Cc: dsd@gentoo.org, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: 2.6.19.2 regression introduced by "IPV4/IPV6: Fix inet{,6}
 device initialization order."
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF0ECEC103.470302BB-ON88257264.00142A49-88257264.0014DC27@us.ibm.com>
References: <45AAF3AC.3070600@gentoo.org>
	<OF0ECEC103.470302BB-ON88257264.00142A49-88257264.0014DC27@us.ibm.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <dlstevens@us.ibm.com>
Date: Sun, 14 Jan 2007 19:47:49 -0800

> I think it's better to add the fix than withdraw this patch, since
> the original bug is a crash.

I completely agree.
