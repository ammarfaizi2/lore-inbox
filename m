Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274923AbTHKWeY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274928AbTHKWeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:34:24 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:10514
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S274923AbTHKWeX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:34:23 -0400
Date: Mon, 11 Aug 2003 15:34:23 -0700
To: Daniela Engert <dani@ngrt.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Serial ATA chipset
Message-ID: <20030811223423.GA9955@nasledov.com>
References: <20030811063403.GA11723@nasledov.com> <20030811064757.7B1CF1C92C@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811064757.7B1CF1C92C@mail.medav.de>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 08:48:25AM +0200, Daniela Engert wrote:
> Ok, fine. This device should work at least in generic PCI IDE busmaster
> mode - even at full speed because of SATA.

Do I need to enable anything specific? I realized that I had neglected
to get the proper SATA power cable, so I just got one and I plugged in
my new SATA drive. There is no indication in my dmesg of any SATA
chipset or any connected SATA drives. I have the "Generic IDE
chipsets" option enabled, along with the PDC2026XX IDE card and the
VIA82CXXX chipset.
-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
