Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWB1AOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWB1AOf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWB1AOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:14:35 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29663 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750938AbWB1AOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:14:34 -0500
Subject: Re: libata PATA patch for 2.6.16-rc5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mathieu Chouquet-Stringer <ml2news@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3k6bgk7oi.fsf@localhost.localdomain>
References: <1141054370.3089.0.camel@localhost.localdomain>
	 <m3k6bgk7oi.fsf@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Feb 2006 00:19:12 +0000
Message-Id: <1141085952.3089.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-27 at 18:55 +0100, Mathieu Chouquet-Stringer wrote:
> What does your roadmap look like now? Will you feed these patches to Jeff
> Garzik when 2.6.17 opens or will you wait to have most of the stuff you
> labelled "core features" completed?

On the whole I'd like to see the core and most of the drivers pushed to
2.6.17 as experimental and merged with the main tree. The DMA CRC
changedown work is important before it leaves "experimental" status.

Up to Jeff and I need to discuss it with him next week.

Alan

