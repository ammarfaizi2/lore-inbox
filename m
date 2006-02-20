Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWBTIbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWBTIbl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 03:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWBTIbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 03:31:41 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13207
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932287AbWBTIbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 03:31:41 -0500
Date: Mon, 20 Feb 2006 00:31:46 -0800 (PST)
Message-Id: <20060220.003146.93580812.davem@davemloft.net>
To: dim@openvz.org
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       rusty@rustcorp.com.au, akpm@osdl.org, devel@openvz.org
Subject: Re: [PATCH 1/2] iptables 32bit compat layer
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200602201110.39092.dim@openvz.org>
References: <200602201110.39092.dim@openvz.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mishin Dmitry <dim@openvz.org>
Date: Mon, 20 Feb 2006 11:10:38 +0300

> This patch set extends current iptables compatibility layer in order
> to get 32bit iptables to work on 64bit kernel. Current layer is
> insufficient due to alignment checks both in kernel and user space
> tools.

Thanks a lot for doing this work Mishin.
