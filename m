Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVDAEqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVDAEqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 23:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVDAEq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 23:46:29 -0500
Received: from webmail.topspin.com ([12.162.17.3]:58086 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262623AbVDAEqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 23:46:19 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][1/3] IPoIB: set skb->mac.raw on receive
X-Message-Flag: Warning: May contain useful information
References: <20053311936.983q6QLaPvAkIcQj@topspin.com>
	<20050331201817.64fe1b69.davem@davemloft.net>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 31 Mar 2005 20:24:10 -0800
In-Reply-To: <20050331201817.64fe1b69.davem@davemloft.net> (David S.
 Miller's message of "Thu, 31 Mar 2005 20:18:17 -0800")
Message-ID: <52ekdvktud.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Apr 2005 04:24:10.0876 (UTC) FILETIME=[A72BBBC0:01C53672]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Roland, netdev@oss.sgi.com CC:'ing either Jeff Garzik and
    David> myself, please.

Sorry, will do next time around, unless you'd like me to resend this
batch as well.  All 3 patches are pretty trivial, though.  The biggest
one is just deleting a lot of code by switching to debugfs.

 - R.
