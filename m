Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbTENUCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 16:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTENUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 16:02:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27294 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262042AbTENUCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 16:02:03 -0400
Date: Wed, 14 May 2003 13:14:31 -0700 (PDT)
Message-Id: <20030514.131431.35680849.davem@redhat.com>
To: rddunlap@osdl.org
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       acme@conectiva.com.br
Subject: Re: 2.5 qdisc problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030514130508.4c6ece84.rddunlap@osdl.org>
References: <20030514130838.GJ15261@suse.de>
	<20030514.125923.102559449.davem@redhat.com>
	<20030514130508.4c6ece84.rddunlap@osdl.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Randy.Dunlap" <rddunlap@osdl.org>
   Date: Wed, 14 May 2003 13:05:08 -0700

   you can set initcall_debug=1 on the kernel command line

Thanks for the tip. :-)

But I know what the invocation ordering is, I think that we merely do
not realize what the dependency is.
