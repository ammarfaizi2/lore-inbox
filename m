Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136496AbRD3RGc>; Mon, 30 Apr 2001 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136498AbRD3RGS>; Mon, 30 Apr 2001 13:06:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6153 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136496AbRD3RGH>; Mon, 30 Apr 2001 13:06:07 -0400
Subject: Re: Oopses under 2.4.4pre8 with Tbird 1.2GHz/Epox 8kta3
To: gold@shell.aros.net (Lawrence Gold)
Date: Mon, 30 Apr 2001 18:07:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010430001754.A96437@shell.aros.net> from "Lawrence Gold" at Apr 30, 2001 12:17:54 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uH99-0008IA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could this be a sign of a faulty 3DNOW! core in my CPU?  If so, do you
> know of any utilities I could run that test these instructions?  (For
> Linux or Windows.)

This problem is only seen on VIA chipsets so far. Never on AMD ones. This leads
me to the current tentative diagnosis of 'VIA chipset bug'
