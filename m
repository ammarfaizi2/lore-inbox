Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUKAImW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUKAImW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 03:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUKAImW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 03:42:22 -0500
Received: from eva.fit.vutbr.cz ([147.229.10.14]:21004 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S261607AbUKAImS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 03:42:18 -0500
Date: Mon, 1 Nov 2004 09:42:11 +0100
From: David Jez <dave.jez@seznam.cz>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
Message-ID: <20041101084211.GA98600@stud.fit.vutbr.cz>
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net> <20041025161945.GA82114@stud.fit.vutbr.cz> <20041029081848.GA5240@stud.fit.vutbr.cz> <41821250.70502@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41821250.70502@verizon.net>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Naah.  I have a piix chipset.  My problem (per David Hinds) is that my 
> laptop is even more b0rken than yours - IBM never hooked up the PCI INTx 
> lines on the TI 1130.  My laptop never worked with Cardbus stuff - even in 
> Windows.
  Jim, just for fun: can you send me your dmesg, lspci -n and dump_pirq
results?

-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=[ ~EOF ]=------------------------------------
