Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWJHPNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWJHPNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWJHPNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:13:15 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:38826 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751209AbWJHPNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:13:14 -0400
Subject: Re: + clocksource-initialize-list-value.patch added to -mm tree
From: Daniel Walker <dwalker@mvista.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: tglx@linutronix.de, akpm@osdl.org, johnstul@us.ibm.com, mingo@elte.hu,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1160320043.3000.178.camel@laptopd505.fenrus.org>
References: <200610070153.k971rsDf020869@shell0.pdx.osdl.net>
	 <1160301039.22911.22.camel@localhost.localdomain>
	 <1160318579.3693.8.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <1160320043.3000.178.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 08:13:12 -0700
Message-Id: <1160320392.3693.28.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 17:07 +0200, Arjan van de Ven wrote:
> 
> so do it. The ones that are in development are easily fixed and
> consistency is worth a LOT in terms of API. Bonus points if the kernel
> printk's a helpful message on abuse.
> 

I was kicking myself for the "clocksource" kernel parameter removal, but
I guess that's more akin to being exposed to userspace. 

The printks might just end up being an OOPS, but I can look into it.

Daniel

