Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278391AbRKDW3g>; Sun, 4 Nov 2001 17:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278403AbRKDW30>; Sun, 4 Nov 2001 17:29:26 -0500
Received: from mail301.mail.bellsouth.net ([205.152.58.161]:52603 "EHLO
	imf01bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278391AbRKDW3V>; Sun, 4 Nov 2001 17:29:21 -0500
Message-ID: <3BE5C136.2259F283@mandrakesoft.com>
Date: Sun, 04 Nov 2001 17:29:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: Manfred Spraul <manfred@colorfullife.com>, John Fremlin <john@fremlin.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [POLITICAL] Re: ECS k7s5a audio sound SiS 735 - 7012
In-Reply-To: <20011104180055.F2312-100000@gerard>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
> different from Tekram adapters. Btw, my Netgear FA311 board is not handled
> by the sis driver of linux-2.2.20 and my little finger tells me that it
> could be so given a few code addition.

Unless you have a really strange board I haven't seen, NetGear FA311 are
the natsemi DP83815/6 chips, handling by either "natsemi" or "fa311"
drivers, not "sis900" driver...

What's the PCI id?

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

