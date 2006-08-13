Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWHMSsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWHMSsh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 14:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWHMSsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 14:48:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38125 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751334AbWHMSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 14:48:36 -0400
Subject: Re: IRQ Issues with 2.6.17.8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Manley <darkhack@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6b4360c80608131102g5fa30b21gfc9b2f83996a1f63@mail.gmail.com>
References: <6b4360c80608130836t1169daf2vd5bc6a0a373989e8@mail.gmail.com>
	 <1155489057.24077.152.camel@localhost.localdomain>
	 <6b4360c80608131102g5fa30b21gfc9b2f83996a1f63@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 13 Aug 2006 20:08:58 +0100
Message-Id: <1155496139.24077.167.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-08-13 am 13:02 -0500, ysgrifennodd Nick Manley:
> I'm not a master of kernel messages but a few of the messages such as
> the "mp-bios bug" and "cannot allocate region 3 of device" which
> appeared during the boot process of several distros made me worry.

I can understand that.

> I'll report this to the ndiswrapper developers.  I'm sorry if I took
> up your time.  I really appreciate your efforts.  Thank you for all of
> your help.

Thanks for providing a detailed report which made it easy to
investigate.

