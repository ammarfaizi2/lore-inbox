Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWFHWNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWFHWNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 18:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWFHWNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 18:13:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10945
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965012AbWFHWNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 18:13:46 -0400
Date: Thu, 08 Jun 2006 15:13:47 -0700 (PDT)
Message-Id: <20060608.151347.55505744.davem@davemloft.net>
To: gerrit@erg.abdn.ac.uk
Cc: jmorris@namei.org, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6-mm1 ] net: RFC 3828-compliant UDP-Lite
 support
From: David Miller <davem@davemloft.net>
In-Reply-To: <200606082109.34338.gerrit@erg.abdn.ac.uk>
References: <20060608.115331.71094388.davem@davemloft.net>
	<Pine.LNX.4.64.0606081542390.3555@d.namei>
	<200606082109.34338.gerrit@erg.abdn.ac.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Date: Thu, 8 Jun 2006 21:09:33 +0100

> That is why I held back regarding the IPv6 port: I can ensure that
> this (IPv4) code is up to standard and to date, but am lacking the
> required additional time to implement the same for IPv6.  I am
> trying to contact people to help with the port, but for the moment I
> will take responsibility only for the IPv4 version.

It's not like an ipv6 port is such a big pile of work.

I'd say it would take you an afternoon, max.

You don't have to test it to the point where it is ISO9000 compliant,
that's not what is being asked of you.
