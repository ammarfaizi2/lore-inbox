Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265277AbUBIRv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 12:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUBIRv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 12:51:26 -0500
Received: from dsl-082-083-132-139.arcor-ip.net ([82.83.132.139]:5511 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S265277AbUBIRvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 12:51:25 -0500
Date: Mon, 9 Feb 2004 18:51:19 +0100
From: Dominik Kubla <dominik@kubla.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Nick Craig-Wood <ncw1@axis.demon.co.uk>,
       Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209175119.GC1795@intern.kubla.de>
References: <c07c67$vrs$1@terminus.zytor.com> <20040209092915.GA11305@axis.demon.co.uk> <20040209124739.GC1738@mail.shareable.org> <20040209134005.GA15739@axis.demon.co.uk> <Pine.LNX.4.53.0402090853020.8894@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402090853020.8894@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 09:00:24AM -0500, Richard B. Johnson wrote:
> > On Mon, Feb 09, 2004 at 07:17:27AM +0000, H. Peter Anvin wrote:
> > > Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?
> 
> Only people who want to log-in from the network..... Of course
> you could force a re-write of all the stuff like telnet, adding
> another layer of bugs that'll take another N years to find and
> remove.

What are you talking about?  On my system (Debian Sid) there are no BSD
pty's (i removed the device nodes) and everything works without even a
recompile.

Regards,
  Dominik
-- 
This fortune was brought to you by the people at Hewlett-Packard.
