Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVG0AFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVG0AFB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVG0ADp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:03:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10151
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262428AbVG0ADe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:03:34 -0400
Date: Tue, 26 Jul 2005 17:03:49 -0700 (PDT)
Message-Id: <20050726.170349.10935659.davem@davemloft.net>
To: mpm@selenic.com
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] NETCONSOLE must depend on INET
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050726235824.GN12006@waste.org>
References: <20050726232043.GB7425@waste.org>
	<20050726.163202.119887768.davem@davemloft.net>
	<20050726235824.GN12006@waste.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Tue, 26 Jul 2005 16:58:24 -0700

> On Tue, Jul 26, 2005 at 04:32:02PM -0700, David S. Miller wrote:
> > More seriously, please submit a version of whatever you
> > believe to be the more correct fix so it can be reviewed
> > and integrated.
> 
> Do you have a preferred location to put this function or
> shall I invent one?

I actually can't wait to see where you're going to
to put a function that transforms "IPV4 addresses"
from ascii other than some place protected by CONFIG_INET.
:-)
