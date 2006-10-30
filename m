Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161538AbWJ3XGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161538AbWJ3XGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161532AbWJ3XG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:06:29 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8867
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161371AbWJ3XG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:06:29 -0500
Date: Mon, 30 Oct 2006 15:06:24 -0800 (PST)
Message-Id: <20061030.150624.97264919.davem@davemloft.net>
To: heiko.carstens@de.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [patch 3/5] net: fix uaccess handling
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061026130317.GD7127@osiris.boeblingen.de.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com>
	<20061026130317.GD7127@osiris.boeblingen.de.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 26 Oct 2006 15:03:17 +0200

> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  net/ipv4/raw.c           |   17 +++++++++++------
>  net/ipv6/raw.c           |   17 +++++++++++------
>  net/netlink/af_netlink.c |    5 +++--
>  3 files changed, 25 insertions(+), 14 deletions(-)

Patch applied, thanks.
