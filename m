Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbQLOAVS>; Thu, 14 Dec 2000 19:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLOAVK>; Thu, 14 Dec 2000 19:21:10 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33284 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135318AbQLOAUz>; Thu, 14 Dec 2000 19:20:55 -0500
Subject: Re: test13-pre1 changelog
To: sfrost@snowman.net (Stephen Frost)
Date: Thu, 14 Dec 2000 23:51:56 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel),
        netfilter@us5.samba.org (Netfilter)
In-Reply-To: <20001214184544.O26953@ns> from "Stephen Frost" at Dec 14, 2000 06:45:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146iAI-0000IA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> machine?  For no apparent reason after 5 days running 2.4.0test12
> everything going through my firewall (set up using iptables) I got about
> 100ms time added on to pings and traceroutes.  I'll probably reboot the
> machine tonight and see if that helps.

Before you do that can you see if ifconfig down, rmmod, insmod, ifconfig up
fixes it. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
