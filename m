Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267329AbUBSVMf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbUBSVMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:12:35 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:1293 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267329AbUBSVMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:12:08 -0500
From: Vlasenko Denis <vda@port.imtp.ilyichevsk.odessa.ua>
To: Carl Thompson <cet@carlthompson.net>
Subject: Re: hard lock using combination of devices
Date: Thu, 19 Feb 2004 23:04:28 +0200
User-Agent: KMail/1.5.4
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net> <200402190013.55033.vda@port.imtp.ilyichevsk.odessa.ua> <20040218152042.st14wg8ggg4444gg@carlthompson.net>
In-Reply-To: <20040218152042.st14wg8ggg4444gg@carlthompson.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402192304.28144.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> >> ERR:     275764
> >
> > You seem to have lots of ERRs too, ~1 each 2 secs.
> > That's bad, maybe flakey interrupt controller?
> > BIOS writers paying dirty with SMM?
>
> Hmmm... Didn't notice that.  Is there anything that can be done about it?

Play with BIOS settings, watch 'cat /proc/interrupts'

> > I had such problems with 11g card and 'latest' BIOS for
> > my old mainboard. Older BIOS was ok.
>
> There are no BIOS downloads available for my notebook, unfortunately.
>
> What 11g card and driver are you using?

Prism GT based one. http://prism54.org
--
vda

