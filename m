Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTHXAt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 20:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbTHXAt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 20:49:58 -0400
Received: from CPE-203-51-27-20.nsw.bigpond.net.au ([203.51.27.20]:35055 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S262116AbTHXAt5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 20:49:57 -0400
Message-ID: <3F480BAB.DD644074@eyal.emu.id.au>
Date: Sun, 24 Aug 2003 10:49:47 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-rc2-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-rc3 - unresolved
References: <Pine.LNX.4.55L.0308231429530.19769@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -rc3

depmod: *** Unresolved symbols in
/lib/modules/2.4.22-rc3/kernel/drivers/net/tc35815.o
depmod:         tc_readl
depmod:         tc_writel

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
