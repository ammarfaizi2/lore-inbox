Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTHUKl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTHUKl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:41:27 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21255 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262574AbTHUKlY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:41:24 -0400
Date: Thu, 21 Aug 2003 06:33:07 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DVD ROM on 2.6
In-Reply-To: <1061423984.1199.7.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1030821063108.19515B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2003, Alan Cox wrote:

> On Mer, 2003-08-20 at 19:06, bill davidsen wrote:
> > If iso9660 looks enough like UDF to confuse the f/s typing logic, would
> > the problem go away if the iso9660 were checked first? It seems iso9660
> > can be mistaken for UDF, is the converse true?
> > 
> > In any case it can be set explicitly.
> 
> Disks can be mastered with both

Good point, but I hope that if that is the case it would work as either,
and the UDF mount would have worked. Perhaps that also would have worked
with a bit of option support.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

