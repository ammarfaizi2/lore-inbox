Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWJCLBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWJCLBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWJCLBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:01:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51179 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030298AbWJCLBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 07:01:10 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20061003012241.GF3278@stusta.de>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	 <20061002234428.GE3278@stusta.de>  <20061003012241.GF3278@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2006 12:24:45 +0100
Message-Id: <1159874685.17553.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-03 am 03:22 +0200, ysgrifennodd Adrian Bunk:
> This patch was already sent on:
> - 7 Jul 2006
> - 26 Jun 2006
> - 27 Apr 2006
> - 19 Apr 2006
> - 6 Jan 2006
> - 13 Dec 2005
> - 23 Nov 2005
> - 18 Nov 2005
> - 12 Nov 2005

This patch was already NAKed on
...

These functions are used internally in the x86 core code correctly and
validly. It's just as easy to find the offenders with grep or building a
PPC tree.

