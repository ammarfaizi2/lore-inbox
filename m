Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVG0VZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVG0VZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVG0VZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 17:25:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24733
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262454AbVG0VZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 17:25:12 -0400
Date: Wed, 27 Jul 2005 14:24:58 -0700 (PDT)
Message-Id: <20050727.142458.112852452.davem@davemloft.net>
To: n.sillik@temple.edu
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 2.6.13-rc3-mm2]net/ipv4/netfilter/ip_conntrack_core.c
 fix -Wundef error
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42E7F377.9040107@temple.edu>
References: <42E7F377.9040107@temple.edu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Sillik <n.sillik@temple.edu>
Date: Wed, 27 Jul 2005 16:49:59 -0400

> Sorry for the resend and previously bad subject line.
> 
> This fixes a single -Wundef error in the file
> net/ipv4/netfilter/ip_conntrack_core.c ,

Please supply a proper Signed-off-by: line with your
patch.
