Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263318AbRFFHps>; Wed, 6 Jun 2001 03:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbRFFHpi>; Wed, 6 Jun 2001 03:45:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21257 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263318AbRFFHpW>; Wed, 6 Jun 2001 03:45:22 -0400
Subject: Re: Lockup in 2.4.5-ac2
To: glenn@gecpalau.com (Glenn Shannon)
Date: Wed, 6 Jun 2001 08:43:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01060610004000.00930@metukerdelong> from "Glenn Shannon" at Jun 06, 2001 10:00:40 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157Xy1-0007xy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Enjoying the -ac2 kernel except for one minor thing: it locks up.

rtl8139

> Realtek 8139B (see attached dmesg.output file)
> 10BaseT Network with 128K Satellite link to outside world

Yep.

Upgrade to a newer -ac and the lockups should stop

