Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270333AbTGNLeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270364AbTGNLeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:34:22 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:62469 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270333AbTGNLeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:34:18 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Mon, 14 Jul 2003 19:37:29 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <200307141725.27304.mflt1@micrologica.com.hk> <20030714120134.A18177@flint.arm.linux.org.uk>
In-Reply-To: <20030714120134.A18177@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307141937.29584.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 July 2003 19:01, Russell King wrote:
> On Mon, Jul 14, 2003 at 05:28:24PM +0800, Michael Frank wrote:
> > Very funny - suspend/resume is not implemented ;)
>
> It hasn't been implemented properly for a long long time.
>
> I think I have all the bits necessary, but need testers willing to
> try stuff out.  I'll produce a patch in the next couple of days.

Thank you, I look forward to testing it.

Regards
Michael

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

