Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbTDKAdb (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTDKAdb (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:33:31 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:7690 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S262180AbTDKAda (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 20:33:30 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, root@chaos.analogic.com,
       Frank Davis <fdavis@si.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-english user messages
References: <3E93A958.80107@si.rr.com>
	<20030409080803.GC29167@mea-ext.zmailer.org>
	<20030409080803.GC29167@mea-ext.zmailer.org>
	<20030409190700.H19288@almesberger.net> <3E94A1B4.6020602@si.rr.com>
	<Pine.LNX.4.53.0304092126130.992@chaos>
	<1050001030.12494.1.camel@dhcp22.swansea.linux.org.uk>
	<shsvfxm157p.fsf@charged.uio.no>
	<1050003748.12494.42.camel@dhcp22.swansea.linux.org.uk>
From: Christer Weinigel <christer@weinigel.se>
Date: 11 Apr 2003 02:48:42 +0200
In-Reply-To: <1050003748.12494.42.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <m31y09uadx.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Thu, 2003-04-10 at 21:13, Trond Myklebust wrote:
> > Which features in particular were you thinking would be worth porting?
> 
> Give me the clustering support 8)

One of the things I really liked with VMS was the centralized logging
in a clustered system.  I'd very much like to be able to say "give me
all syslog messages for the mail subsystem at this severity level or
above" instead of having to play around with /etc/syslog.conf,
restarting syslogd and tail -f.  Of course this isn't a kernel
problem, it's something that should be implemented in syslog, but it's
just an example of a good idea in VMS.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
