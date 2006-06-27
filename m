Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWF0O2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWF0O2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWF0O2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:28:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:53218 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161068AbWF0O2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:28:12 -0400
Date: Tue, 27 Jun 2006 16:27:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Dave Jones <davej@redhat.com>
cc: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
In-Reply-To: <20060626155439.GB18599@redhat.com>
Message-ID: <Pine.LNX.4.61.0606271626470.10810@yvahk01.tjqt.qr>
References: <20060626151012.GR23314@stusta.de> <20060626153834.GA18599@redhat.com>
 <1151336815.3185.61.camel@laptopd505.fenrus.org> <20060626155439.GB18599@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > cli/sti should just be removed, or at least have those drivers marked
> > BROKEN... nobody is apparently using them anyway...
>
>Just ISDN really.
>
And ISDN is widespread in Germany (besides 56k and DSL(PPPOE)).


Jan Engelhardt
-- 
