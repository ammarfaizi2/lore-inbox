Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTD2Mq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTD2Mq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:46:26 -0400
Received: from [193.89.230.30] ([193.89.230.30]:31890 "EHLO
	roadrunner.hulpsystems.net") by vger.kernel.org with ESMTP
	id S261860AbTD2MqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:46:25 -0400
Message-ID: <1051621120.3eae7700b1586@roadrunner.hulpsystems.net>
Date: Tue, 29 Apr 2003 14:58:40 +0200
From: Martin List-Petersen <martin@list-petersen.dk>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       bas.mevissen@hetnet.nl
Subject: RE: Broadcom BCM4306/BCM2050  support
References: <472501c30e4a$c596d0b0$d16897c2@hetnet.nl>
In-Reply-To: <472501c30e4a$c596d0b0$d16897c2@hetnet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citat bas.mevissen@hetnet.nl:
 
> > /me wants binary only driver for these cards to build opensource driver
> > with ability to set "interesting" frequency range.
>
> > Carl-Daniel
>
> But I don't want to read in the papers that Linux was used as an illegal
> hacker tool to snoop into mil stuff...

Ehh .. no .. probably wouldn't be nice, but you cat do stuff like that on any
OS, so that doesn't really matter.

For my case, i would be glad if I just could do 802.11b on these cards right
now. 802.11g and 802.11a would be nice though.

However, if it is like that (the chip supports all frequencies), that would
mean, that a TrueMobile 1300 and TrueMobile 1400 practically is the same card.
(TM1300: 802.11b/g, TM1400: 802.11a/b/g)

Another thing about the TM1400 is, that it has 2 MAC adresses, but that's
probably due to, that 802.11a operates on another frequency than 802.11b/g (one
MAC is assigned to 802.11a, the other one to 802.11g).

Regards,
Martin List-Petersen
martin at list-petersen dot dk
-- 
The probability of someone watching you is proportional to the
stupidity of your action. 
