Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267210AbTGTPSP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267260AbTGTPSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 11:18:15 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:46394 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S267210AbTGTPSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 11:18:14 -0400
Subject: Re: More ACPI funnies in 2.6.0test1
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Sean Neakums <sneakums@zork.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <6u1xwl8bth.fsf@zork.zork.net>
References: <1058714000.2488.2.camel@aurora.localdomain>
	 <6u1xwl8bth.fsf@zork.zork.net>
Content-Type: text/plain
Message-Id: <1058715193.2488.9.camel@aurora.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 20 Jul 2003 11:33:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-07-20 at 11:20, Sean Neakums wrote:
> "Trever L. Adams" <tadams-lists@myrealbox.com> writes:
> 
> > 1) My disk seems to be more active, I hear it clicking much more
> 
> Any chance this is due to increased logging activity to files that are
> marked synchronous (with a -) in syslog.conf?

At least in /etc/syslog.conf on my RH9/RH Rawhide system there is no a-
anywhere in the syslog.conf.  Not only that, but I don't seem to have
much more logging going on, in fact maybe a bit less.  Exceptions:
smartd (which seems to only log about once an hour, so this isn't it)
and a few places where char 188 and char 10_133, I think it is, are not
found (just fixed this, and this doesn't happen much either).

Trever
--
I love dogs, but I hate Chihuahuas. A Chihuahua isn't a dog. It's a rat
with a thyroid problem. -- Unknown

