Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVAXXIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVAXXIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVAXVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:30:37 -0500
Received: from ns.suse.de ([195.135.220.2]:26070 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261587AbVAXUg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:36:29 -0500
Date: Mon, 24 Jan 2005 21:36:24 +0100
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124203624.GB14335@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124121226.GA29098@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124121226.GA29098@infradead.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 12:12:26PM +0000, Christoph Hellwig wrote:
> > +i4l-new-hfc_usb-driver-version.patch
> 
> this drivers wants:
> 
>  - update for Documentation/CodingStyle

agree, I only take the patch from chip manufacturer and
test compiling and working with my hardware and do not look at code style
yet.

>  - conversion to proper pci API

??? the driver is not PCI related at all


-- 
Karsten Keil
SuSE Labs
ISDN development
