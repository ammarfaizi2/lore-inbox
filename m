Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVADNX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVADNX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVADNWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:22:40 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:44450 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261609AbVADNWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:22:02 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Thomas Molina <tmolina@cablespeed.com>
Subject: Re: 2.6.10-mm1 [failure on AMD64]
Date: Tue, 4 Jan 2005 14:22:20 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050103011113.6f6c8f44.akpm@osdl.org> <200501040029.15623.rjw@sisk.pl> <Pine.LNX.4.61.0501040613240.4992@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.61.0501040613240.4992@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501041422.21159.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 4 of January 2005 12:23, Thomas Molina wrote:
> On Tue, 4 Jan 2005, Rafael J. Wysocki wrote:
> 
> > On a UP AMD64 it boots, but then it does not work appropriately (eg. at 
KDE
> > startup the box hangs for a while and I get the message like "The process 
for
> > the file protocol has terminated unexpectedly" and desktop icons are not
> > displayed, and I get a "cpu overload" message from arts etc.).
> 
> I also tried it on an AMD64 system (3500+ on A8V Deluxe) and did not 
> observe any anomalies, but I am using Gnome, not KDE.

Now I'm not seeing anything wrong either, so it must have been accidental.  I 
suspect that the problem was with artsd.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
