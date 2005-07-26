Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVGZWlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVGZWlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVGZWlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:41:12 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55727
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262288AbVGZWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:39:35 -0400
Date: Tue, 26 Jul 2005 15:39:42 -0700 (PDT)
Message-Id: <20050726.153942.24671899.davem@davemloft.net>
To: bunk@stusta.de
Cc: netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix ip_conntrack_put prototype
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050726145659.GR3160@stusta.de>
References: <20050726145659.GR3160@stusta.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 26 Jul 2005 16:56:59 +0200

> The function is not inline.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>


Applied, thanks Adrian.
