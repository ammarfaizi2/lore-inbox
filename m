Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTJTHWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTJTHWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:22:23 -0400
Received: from line103-242.adsl.actcom.co.il ([192.117.103.242]:63882 "EHLO
	beyondmobile1.beyondsecurity.com") by vger.kernel.org with ESMTP
	id S262412AbTJTHWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:22:19 -0400
From: Aviram Jenik <aviram@beyondsecurity.com>
Organization: Beyond Security Ltd.
To: "Brown, Len" <len.brown@intel.com>, "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test8 compilation issue
Date: Mon, 20 Oct 2003 09:22:59 +0200
User-Agent: KMail/1.5.4
References: <BF1FE1855350A0479097B3A0D2A80EE0CC87B8@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC87B8@hdsmsx402.hd.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310200922.59544.aviram@beyondsecurity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 October 2003 05:57, Brown, Len wrote:
> > drivers/built-in.o(.init.text+0x8cc): In function `acpi_bus_init':
> > : undefined reference to `eisa_set_level_irq'
> >
> > make: *** [.tmp_vmlinux1] Error 1
>
> If adding CONFIG_PCI isn't a viable workaround for you let me know,
> and I'll send you the fix I've got staged.
>

That workaround it quite ok for me.
However, if you need testers for your fix, I'd be glad to help.

- Aviram
