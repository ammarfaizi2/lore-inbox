Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVGYCV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVGYCV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 22:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVGYCV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 22:21:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10184
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261625AbVGYCVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 22:21:52 -0400
Date: Sun, 24 Jul 2005 19:21:59 -0700 (PDT)
Message-Id: <20050724.192159.107919635.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: netfilter-devel@lists.netfilter.org
Subject: (was Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG)
 Fw: Mail delivery failed: returning message to sender
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Sun_Jul_24_19_21_59_2005_304)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Sun_Jul_24_19_21_59_2005_304)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Well, this may be the reason why Evgeniy thinks nobody
has any concrete objections to his connector layer :-(

----Next_Part(Sun_Jul_24_19_21_59_2005_304)--
Content-Type: Message/Rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Return-path: <>
Envelope-to: davem@davemloft.net
Delivery-date: Sun, 24 Jul 2005 19:18:01 -0700
Received: from Debian-exim by sunset.davemloft.net with local (Exim 4.52)
	id 1DwsXZ-0007ps-1u
	for davem@davemloft.net; Sun, 24 Jul 2005 19:18:01 -0700
X-Failed-Recipients: johnpol@2ka.mipt.ru
Auto-Submitted: auto-generated
From: Mail Delivery System <Mailer-Daemon@sunset.davemloft.net>
To: davem@davemloft.net
Subject: Mail delivery failed: returning message to sender
Message-Id: <E1DwsXZ-0007ps-1u@sunset.davemloft.net>
Date: Sun, 24 Jul 2005 19:18:01 -0700

This message was created automatically by mail delivery software.

A message that you sent could not be delivered to one or more of its
recipients. This is a permanent error. The following address(es) failed:

  johnpol@2ka.mipt.ru
    SMTP error from remote mail server after initial connection:
    host mailer.campus.mipt.ru [194.85.82.4]: 554 mailer.campus.mipt.ru ESMTP not accepting messages

------ This is a copy of the message, including all the headers. ------

Return-path: <davem@davemloft.net>
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.52)
	id 1DwsXV-0007pe-24; Sun, 24 Jul 2005 19:17:57 -0700
Date: Sun, 24 Jul 2005 19:17:56 -0700 (PDT)
Message-Id: <20050724.191756.105797967.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1 Wire drivers illegally overload NETLINK_NFLOG
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050723091455.GA12015@2ka.mipt.ru>
References: <20050723125427.GA11177@rama>
	<20050723091455.GA12015@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Sat, 23 Jul 2005 13:14:55 +0400

> Andrew has no objection against connector and it lives in -mm

A patch sitting in -mm has zero significance.  A lot of junk
and useless things end up there as often Andrew incorporates
just about every single patch he sees posted to linux-kernel
unless he personally knows of some reason why the change might
be wrong.

So "it's in -mm" is not a metric to use.

> All objections against it was only type of - "I do not like it"
> Dmitry had some bugfixes which were added.

People like James Morris had very specific objections about it.

You are a control freak and in general very very difficult to work
with, so nobody wants to help you fix things up.

----Next_Part(Sun_Jul_24_19_21_59_2005_304)----
