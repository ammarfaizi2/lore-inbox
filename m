Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264360AbUEKVqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbUEKVqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUEKVqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:46:15 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:46599 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264402AbUEKVp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:45:59 -0400
Date: Tue, 11 May 2004 23:45:58 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: problem with sis900
Message-ID: <20040511214558.GC19101@picchio.gall.it>
Mail-Followup-To: Dominik Karall <dominik.karall@gmx.net>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1084300104.24569.8.camel@datacontrol> <200405112101.09525.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405112101.09525.dominik.karall@gmx.net>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 09:01:09PM +0200, Dominik Karall wrote:
> I have problems with sis900 driver too. I can only use the ethernet card in 
> half duplex mode. At startup I get following messages:

These problems were always there or started at a particular kernel
version ? Can you send me a lspci -vvv and a dmesg in the (if any)
working case ?

> It's a SiS900 PCI card, and not a Realtek.
Yes, but it detects the PHY transciver as a realtek one.

Thanks.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

