Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270520AbTHGVTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270630AbTHGVTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:19:00 -0400
Received: from proibm3.procempa.com.br ([200.248.222.108]:59353 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270520AbTHGVS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:18:58 -0400
Date: Thu, 7 Aug 2003 18:21:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: 2.6.0-test2-mm5
In-Reply-To: <20030806223716.26af3255.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0308071819380.4791-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Aug 2003, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm5/
> 
> 
> Lots of different things.  Mainly trying to get this tree stabilised again;
> there has been some breakage lately.

Tried to boot it on OSDL's 8way:

checking TSC synchronization across 8 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
Bringing up 3
CPU 3 IS NOW UP!
Starting migration thread for cpu 3
Bringing up 4
CPU 4 IS NOW UP!
Starting migration thread for cpu 4
Bringing up 5
CPU 5 IS NOW UP!
Starting migration thread for cpu 5
Bringing up 6
CPU 6 IS NOW UP!
Starting migration thread for cpu 6
Bringing up 7
CPU 7 IS NOW UP!
Starting migration thread for cpu 7
CPUS done 16
zapping low mappings.
mtrr: v2.0 (20020519)
Initializing RT netlink socket
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd26c, last bus=15
PCI: Using configuration type 1


Locked up solid there. Want more info ? 

