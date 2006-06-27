Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161075AbWF0PDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161075AbWF0PDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161078AbWF0PDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:03:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28124 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161075AbWF0PDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:03:53 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Jones <davej@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0606271626470.10810@yvahk01.tjqt.qr>
References: <20060626151012.GR23314@stusta.de>
	 <20060626153834.GA18599@redhat.com>
	 <1151336815.3185.61.camel@laptopd505.fenrus.org>
	 <20060626155439.GB18599@redhat.com>
	 <Pine.LNX.4.61.0606271626470.10810@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 27 Jun 2006 16:17:32 +0100
Message-Id: <1151421452.32186.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-27 am 16:27 +0200, ysgrifennodd Jan Engelhardt:
> > > cli/sti should just be removed, or at least have those drivers marked
> > > BROKEN... nobody is apparently using them anyway...
> >
> >Just ISDN really.
> >
> And ISDN is widespread in Germany (besides 56k and DSL(PPPOE)).

Then there should be lots of Germans eager to fix it when it gets dealt
with.

Alan

