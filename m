Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVAYAiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVAYAiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVAYAig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:38:36 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:60603 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261725AbVAYAgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:36:06 -0500
Date: Tue, 25 Jan 2005 01:35:55 +0100
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050125003555.GA17973@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124121226.GA29098@infradead.org> <20050124203624.GB14335@pingi3.kke.suse.de> <20050124232603.GA8332@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124232603.GA8332@infradead.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 11:26:03PM +0000, Christoph Hellwig wrote:
> On Mon, Jan 24, 2005 at 09:36:24PM +0100, Karsten Keil wrote:
> > >  - conversion to proper pci API
> > 
> > ??? the driver is not PCI related at all
> 
> Sorry, this was actually a comment for i4l-hfc-4s-and-hfc-8s-driver.patch.
> 

OK, in the meantime I assumed this too and informed the author about the
problems, I think most things will be solved soon.

I can correct CodingStyle for hfc_usb.c too, this give ~30K bigger patch.

Thanks for the formal code checks, I forget them sometimes, if I get code
from 3 party.

-- 
Karsten Keil
SuSE Labs
ISDN development
