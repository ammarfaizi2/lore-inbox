Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUEXLmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUEXLmt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 07:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUEXLmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 07:42:49 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:54711 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264215AbUEXLmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 07:42:40 -0400
Subject: Linux MTD CVS / lists.infradead.org -- outage / relocation notice
From: David Woodhouse <dwmw2@infradead.org>
Reply-To: dwmw2@infradead.org
To: linux-mtd@lists.infradead.org, linux-pcmcia@lists.infradead.org,
       linux-afs@lists.infradead.org, linux-parport@lists.infradead.org
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org, etux@embeddedtux.org
Content-Type: text/plain
Message-Id: <1085398954.27156.55.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 24 May 2004 12:42:34 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Reply-To set to personal reply. Please don't cross-post. ]

For some time now, the machines running mailing list and CVS services
for Linux MTD development have been on the public side of the Red Hat
Cambridge network. For generously allowing this I would like to thank
the previous manager of the Cambridge office, now with eCosCentric, and
the old sysadmin there, now also moved on.

Last week, some members of the Red Hat IS department took it upon
themselves to demand that the machines be removed. That in itself is not
entirely unreasonable -- but they gave such a short period of notice
that there wasn't enough time to arrange new locations for the machines.
In fact the disconnection was so hasty that there wouldn't even have
been enough notice to turn the DNS expiry times down for the changeover
had I the new homes been already arranged beforehand and had I been able
to move into them during the week.

Although I immediately started to arrange new locations, the Red Hat IS
team did not even do me the courtesy of replying to my email in which I
stated the time it would take to move the machines and requested an
extension of their arbitrarily short deadline to cover this.

However, the deadline of noon on Thursday passed, so I assumed that
sanity had prevailed. Unfortunately this was not the case; on Friday
morning I arrived at work to find that the machines had been
disconnected, still without the courtesy of a reply to my email.

Even now, no reason has been given for the sudden urgency of the
disconnection; no reason why it could not have been done with sufficient
notice to allow a smooth transition or indeed even a single weekend to
perform a more careful migration of services.

In the meantime, the lists.infradead.org mailing lists have been moved
to an alternative machine, which was already an MX backup so mailing
list traffic should continue to work. For list administration tasks, you
may need to use the IP address 2002:cde9:d907::1 or 205.233.217.7
instead of 'lists.infradead.org' until the DNS propagates. 

The CVS server, cvs.infradead.org aka phoenix.infradead.org, is
currently IPv6-only on 2002:c1ed:8229:10:2c0:f0ff:fe31:e18 and will
remain IPv6-only on a 64K ISDN line for the next couple of weeks until
its new home is ready. Those who use it for CVS access or for email and
have a real IPv4 address may want to investigate the three lines they
need to add to their networking config to get IPv6 connectivity using
6to4. Alternatively, contact me to arrange an account on another machine
in the cluster (which will of course be able to communicate with phoenix
via IPv6).

Web services will be coming back up within the next few days in another
location.

All these changes have been made at fairly short notice and without the
amount of planning I would normally have wanted. So please let me know
as soon as possible if anything seems (unexpectedly) wrong.

I apologise for the disruption caused by this unforeseen move. Although
caused by events not strictly within my control, I have to admit that I
have had cause to deal with these people before, and I do know what
they're like. I should not have allowed a situation to arise where a
group of such small-minded, obstructive little men could achieve such
disruption.

-- 
dwmw2

