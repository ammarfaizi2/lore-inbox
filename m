Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbTIDNvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbTIDNvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:51:20 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:17705 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265001AbTIDNvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:51:16 -0400
Date: Thu, 4 Sep 2003 06:51:15 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: bkbits source browsing -- tags
Message-ID: <20030904065115.B12018@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I really like the source browser on linux.bkbits.net.

Is there a way to browse to a file and see which rev is in which kernel
version?  The closest thing I can find is that if I follow the 'CSet'
link, sometimes the Rev data is yellow and has what I'm guessing is a
tag.  But this is clearly not comprehensive.

eg, arch/i386/kernel/apic.c doesn't come close to telling me which is
the apic.c found in (say) 2.4.21.

If there's a way to do this directly from the source browser, that'd
be perfect, but also if there's a way to correlate it somehow with
data I can get elsewhere that's fine too.  eg, from the "start page"
at linux.bkbits.net, if I go to 'Tags', I can find the 2.4.21 tag
("MailDone v2.4.21" I guess is it) and click 'later CSets' but that
information doesn't seem particularly helpful in finding 2.4.21 apic.c.
(Obviously, I'm not even really sure how to read that data.)

thanks
/fc
