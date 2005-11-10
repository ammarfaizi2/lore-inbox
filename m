Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVKJRlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVKJRlh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVKJRlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:41:37 -0500
Received: from tim.rpsys.net ([194.106.48.114]:45728 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751182AbVKJRlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:41:36 -0500
Subject: Re: latest mtd changes broke collie
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Vrabel <dvrabel@cantab.net>, linux-mtd@lists.infradead.org,
       David Woodhouse <dwmw2@infradead.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051110130930.GJ2401@elf.ucw.cz>
References: <20051109221712.GA28385@elf.ucw.cz>
	 <4372B7A8.5060904@mvista.com> <20051110095050.GC2021@elf.ucw.cz>
	 <1131616948.27347.174.camel@baythorne.infradead.org>
	 <20051110103823.GB2401@elf.ucw.cz>
	 <1131619903.27347.177.camel@baythorne.infradead.org>
	 <20051110105954.GE2401@elf.ucw.cz>
	 <1131621090.27347.184.camel@baythorne.infradead.org>
	 <20051110120708.GG2401@elf.ucw.cz> <437344E0.9040502@cantab.net>
	 <20051110130930.GJ2401@elf.ucw.cz>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 17:41:16 +0000
Message-Id: <1131644476.24595.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 14:09 +0100, Pavel Machek wrote:
> > Shouldn't you get hold of the datasheet for the flash chips and fill in
> > this information correctly?
> 
> I already have working sharp.c driver... And I do not even know
> manufacturer of the chip, just its ids.

The chip number is LF28F640BX which is a 64MBit device so perhaps Intel
StrataFlash 28F640? That seems to be a fairly common chip...

Richard

