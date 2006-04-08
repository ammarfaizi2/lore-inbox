Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWDHWFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWDHWFn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 18:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWDHWFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 18:05:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:1502
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751437AbWDHWFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 18:05:43 -0400
Date: Sat, 08 Apr 2006 15:05:33 -0700 (PDT)
Message-Id: <20060408.150533.106945276.davem@davemloft.net>
To: vherva@vianova.fi
Cc: linux-kernel@vger.kernel.org, kaber@trash.net
Subject: Re: Linux 2.6.17-rc1: /sbin/iptables does not find kernel netfilter
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060408200915.GN1686@vianova.fi>
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org>
	<20060408200915.GN1686@vianova.fi>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Herva <vherva@vianova.fi>
Date: Sat, 8 Apr 2006 23:09:15 +0300

> I upgraded from 2.6.15-rc7 to 2.6.17-rc1. rc1 seems nice other than that
> iptables stopped working:

Please report this to the netfilter developer list next time.

Nevertheless I've CC:'d one of the netfilter developers so that it
gets looked into.
