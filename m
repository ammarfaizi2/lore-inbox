Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135576AbRD3Qlv>; Mon, 30 Apr 2001 12:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135852AbRD3Qlm>; Mon, 30 Apr 2001 12:41:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1545 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135576AbRD3Qlc>; Mon, 30 Apr 2001 12:41:32 -0400
Subject: Re: panic when booting 2.4.4
To: jan@gondor.com (Jan Niehusmann)
Date: Mon, 30 Apr 2001 17:43:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010429212545.A2208@gondor.com> from "Jan Niehusmann" at Apr 29, 2001 09:25:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uGlR-0008H9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is on an asus-a7v133 (VIA chipset), Duron 800, HD is hda, CDRW is hdc,
> no other ide devices attached (ie no devices on the onboard promise
> controller)

Yep. Known problem. I sent Linus the fix for that for 2.4.4 but it got missed
somewhere. I'll resend it once Im back in order. For now grab the fix from
2.4-ac
