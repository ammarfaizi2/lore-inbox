Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWFYLBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWFYLBp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWFYLBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:01:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:20924 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932350AbWFYLBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:01:44 -0400
Date: Sun, 25 Jun 2006 13:01:36 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
In-Reply-To: <20060624195409.GA2777@elf.ucw.cz>
Message-ID: <Pine.LNX.4.61.0606251301030.28911@yvahk01.tjqt.qr>
References: <20060619191543.GA17187@rhlx01.fht-esslingen.de>
 <Pine.LNX.4.61.0606191542050.4926@chaos.analogic.com> <20060619202354.GD26759@redhat.com>
 <20060619222528.GC1648@openzaurus.ucw.cz> <Pine.LNX.4.61.0606201156080.2481@yvahk01.tjqt.qr>
 <20060622181658.GA4193@elf.ucw.cz> <Pine.LNX.4.61.0606231930360.26864@yvahk01.tjqt.qr>
 <20060624195409.GA2777@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The best would be to turn the machine off after, say, 60 seconds. (So you 
>> can grab the panic, if there is one.)
>
>I'd rather not overdo it. Shutting machine down is pretty hard
>operation.

Hm. Too bad a CPU does not have a simple low-level trigger for poweroff, 
like there is for reboot when a triplefault occurs.


Jan Engelhardt
-- 
