Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVL0Dde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVL0Dde (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 22:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVL0Dde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 22:33:34 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11435
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932206AbVL0Ddd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 22:33:33 -0500
Date: Mon, 26 Dec 2005 19:33:35 -0800 (PST)
Message-Id: <20051226.193335.48723764.davem@davemloft.net>
To: gcoady@gmail.com, grant_lkml@dodo.com.au
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.14.5
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
References: <20051227005327.GA21786@kroah.com>
	<32b1r156pu7much2m94ajva2bmcs4mpcag@4ax.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grant Coady <grant_lkml@dodo.com.au>
Date: Tue, 27 Dec 2005 14:06:03 +1100

> netfilter is broken compared to 2.6.15-rc7 (first 2.6 kernel tested 
> on this box) or 2.4.32 :(  Same ruleset as used for months.
> 
> Fails to recognise named chains with a useless error message:
> 
> "iptables: No chain/target/match by that name"

Please report it to the netfilter mailing list, which is
where the netfilter developers listen and can attend to
your report.

Thanks a lot.
