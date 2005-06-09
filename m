Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVFICsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVFICsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 22:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVFICsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 22:48:33 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:27012 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262251AbVFICs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 22:48:29 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Adam Belay <abelay@novell.com>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Karsten Keil <kkeil@suse.de>
In-Reply-To: <20050609000402.GA2694@elf.ucw.cz>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <Pine.LNX.4.58.0506061702430.1876@ppc970.osdl.org>
	 <20050607025054.GC3289@neo.rr.com>
	 <20050607105552.GA27496@pingi3.kke.suse.de>
	 <20050607205800.GB8300@neo.rr.com> <1118190373.6850.85.camel@gaston>
	 <1118196980.3245.68.camel@localhost.localdomain>
	 <20050608122320.GC1898@elf.ucw.cz> <1118271605.6850.137.camel@gaston>
	 <20050609000402.GA2694@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1118285390.25506.74.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 09 Jun 2005 12:49:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-06-09 at 10:04, Pavel Machek wrote:
> PMSG_* are for struct; you can't case on struct.

switch (state.event)

Regards,

Nigel

