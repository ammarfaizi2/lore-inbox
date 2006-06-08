Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWFHSwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWFHSwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWFHSwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:52:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36021
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964931AbWFHSwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:52:04 -0400
Date: Thu, 08 Jun 2006 11:51:30 -0700 (PDT)
Message-Id: <20060608.115130.41638734.davem@davemloft.net>
To: gerrit@erg.abdn.ac.uk
Cc: yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, kaber@coreworks.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc6-mm1 ] net: RFC 3828-compliant UDP-Lite
 support
From: David Miller <davem@davemloft.net>
In-Reply-To: <200606081222.54856.gerrit@erg.abdn.ac.uk>
References: <200606081150.34018@this-message-has-been-logged>
	<20060608.200349.81316352.yoshfuji@linux-ipv6.org>
	<200606081222.54856.gerrit@erg.abdn.ac.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Date: Thu, 8 Jun 2006 12:22:54 +0100

> I am sorry, I don't at the moment have the time to port to v6 with the
> same degree of rigour. 

You give the impression that you would just disappear from the face of
the planet should your work actually be integrated into the kernel
tree.

So I can only assume that you are posting this for people to play
around with, and not for serious consideration of inclusion into the
kernel tree.

We're trying to avoid this serious problem we have where a group or
individual submits on a piece of code, works just hard enough to get
it integrated into the tree, then disappears and does not stick around
to support the inevitable ensuing bugs and problem reports.  Such
behavior is totally irresponsible, yet it happens quite a bit.

So if you can't be bothered to cook up IPV6 support, chances are you
won't stick around to support your code if it went into the tree
either.
