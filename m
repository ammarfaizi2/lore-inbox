Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVDADCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVDADCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 22:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbVDADCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 22:02:40 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:53398 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261441AbVDADCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 22:02:38 -0500
Subject: Re: noresume breaks next suspend [was Re: 2.6.12-rc1 swsusp broken]
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Benoit Boissinot <bboissin@gmail.com>, romano@dea.icai.upco.es,
       dtor_core@ameritech.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1112316622.18871.132.camel@desktop.cunningham.myip.net.au>
References: <20050329110309.GA17744@pern.dea.icai.upco.es>
	 <20050329132022.GA26553@pern.dea.icai.upco.es>
	 <20050329170238.GA8077@pern.dea.icai.upco.es>
	 <20050329181551.GA8125@elf.ucw.cz>
	 <20050331144728.GA21883@pern.dea.icai.upco.es>
	 <d120d5000503310715cbc917@mail.gmail.com>
	 <20050331165007.GA29674@pern.dea.icai.upco.es>
	 <40f323d005033110292934aa1d@mail.gmail.com>
	 <20050331222531.GE1802@elf.ucw.cz>
	 <1112316622.18871.132.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Message-Id: <1112324670.18871.269.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 01 Apr 2005 13:04:30 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Fri, 2005-04-01 at 10:50, Nigel Cunningham wrote:
> > OTOH, perhaps refusing suspend is right thing to do. If user is
> > running in "safe mode" (with noresume), we don't want him to be able
> > to suspend...
> 
> What? If you suspend, then decide not to resume, you can suspend again
> until after your next reboot?!

err... "...can't suspend again..."

> Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

