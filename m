Return-Path: <linux-kernel-owner+w=401wt.eu-S1751425AbXAPC4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXAPC4P (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbXAPC4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:56:15 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51576
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751425AbXAPC4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:56:14 -0500
Date: Mon, 15 Jan 2007 18:56:15 -0800 (PST)
Message-Id: <20070115.185615.74746734.davem@davemloft.net>
To: yoshfuji@linux-ipv6.org
Cc: nix.or.die@googlemail.com, greg@kroah.com, stable@kernel.org,
       dlstevens@us.ibm.com, dsd@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: [stable] 2.6.19.2 regression introduced by "IPV4/IPV6: Fix
 inet{, 6} device initialization order."
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070116.110630.60620489.yoshfuji@linux-ipv6.org>
References: <20070115072554.GA16969@kroah.com>
	<45AC3214.4080800@googlemail.com>
	<20070116.110630.60620489.yoshfuji@linux-ipv6.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date: Tue, 16 Jan 2007 11:06:30 +0900 (JST)

> In article <45AC3214.4080800@googlemail.com> (at Tue, 16 Jan 2007 03:01:56 +0100), Gabriel C <nix.or.die@googlemail.com> says:
> 
> > Should be the fix from http://bugzilla.kernel.org/show_bug.cgi?id=7817
> 
> I've resent the patch to <stable@kernel.org>.

Thank you.
