Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274814AbTGaRCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274819AbTGaRCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:02:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50957 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S274814AbTGaRCj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:02:39 -0400
Date: Thu, 31 Jul 2003 12:54:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@osdl.org>
cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2+ext3+dbench=Buffer I/O error
In-Reply-To: <20030730150902.5281f72c.akpm@osdl.org>
Message-ID: <Pine.LNX.3.96.1030731125324.5711A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Andrew Morton wrote:

> Mike Galbraith <efault@gmx.de> wrote:
> >
> > Greetings,
> > 
> > While trying to duplicate Randy Hron's "dbench has intermittent hang on 
> > 2.6.0-test1-ac2" report, I received quite a few "Buffer I/O error on 
> > /dev/hda8, logical block N" messages.  (changing elevators makes no 
> > difference fwiw).
> 
> That's just a gremlinlet.  You can delete the offending printk for now.

I can live with the message, it will remind me that there is still an
issue of some kind. I get it doing other things and on other partitions,
obviously.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

