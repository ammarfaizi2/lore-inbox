Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270753AbTGUXJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 19:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270329AbTGUXJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 19:09:48 -0400
Received: from CPE-203-51-35-8.nsw.bigpond.net.au ([203.51.35.8]:45814 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S270756AbTGUXJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 19:09:47 -0400
Message-ID: <3F1C763E.78D67BC3@eyal.emu.id.au>
Date: Tue, 22 Jul 2003 09:24:46 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.22-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22pre7aa1: unresolved in sk98lin
References: <20030719013223.GA31330@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> URL:
> 
>         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1.bz2
>         http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.22pre7aa1/
> 

depmod: *** Unresolved symbols in
/lib/modules/2.4.22-pre7-aa1/kernel/drivers/net/sk98lin/sk98lin.o
depmod:         __udivdi3

Using Debian stable (woody) - gcc 2.95.4.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
