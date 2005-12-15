Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVLOXMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVLOXMv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 18:12:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVLOXMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 18:12:51 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:47270 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1751097AbVLOXMu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 18:12:50 -0500
From: Ismail Donmez <ismail@uludag.org.tr>
Organization: TUBITAK/UEKAE
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 16 Dec 2005 01:12:29 +0200
User-Agent: KMail/1.9.1
References: <20051211180536.GM23349@stusta.de> <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512160112.30179.ismail@uludag.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cuma 16 Aralık 2005 00:57 tarihinde şunları yazmıştınız:
> >It seems most problems with 4k stacks are already resolved at least
> >in -mm.
> >
> >I'd like to see this patch to always use 4k stacks in -mm now for
> >finding any remaining problems before submitting this patch for Linus'
> >tree.
>
> By chance, I read that windows modules used in ndiswrapper
> may require >4k-stacks. Will this become a problem?

If 8k stacks get removed, yes. So if you have a chance to choose don't buy a 
wifi card which doesn't have a native linux driver.

Regards,
ismail
