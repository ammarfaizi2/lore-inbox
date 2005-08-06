Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbVHFEba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbVHFEba (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 00:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbVHFEba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 00:31:30 -0400
Received: from palrel10.hp.com ([156.153.255.245]:41382 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263163AbVHFEb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 00:31:28 -0400
Date: Fri, 5 Aug 2005 21:33:54 -0700
From: Grant Grundler <iod00d@hp.com>
To: Grant Grundler <iod00d@hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, linville@tuxdriver.com,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       yhlu <yhlu.kernel@gmail.com>
Subject: Re: [openib-general] Re: mthca and LinuxBIOS
Message-ID: <20050806043354.GA27352@esmail.cup.hp.com>
References: <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com> <86802c44050805112661d889aa@mail.gmail.com> <86802c4405080512254b9cd496@mail.gmail.com> <86802c4405080512451cdcae48@mail.gmail.com> <86802c44050805132853070f1@mail.gmail.com> <Pine.LNX.4.58.0508051335440.3258@g5.osdl.org> <20050805220015.GA3524@suse.de> <Pine.LNX.4.58.0508051602350.3258@g5.osdl.org> <20050805235937.GK25121@esmail.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805235937.GK25121@esmail.cup.hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 04:59:37PM -0700, Grant Grundler wrote:
> ISTR making comments before about the offending patch on linux-pci mailing
> list.  Is this the same patch that assumes pci_dev->resource[i] == BAR[i] ?

I meant the patch assume 1:1 for pci_dev->resource[i] and BAR[i].
not that the two are equivalent.

grant
