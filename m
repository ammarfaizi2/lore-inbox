Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269192AbUJKT5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269192AbUJKT5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269214AbUJKT5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:57:19 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:18914 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269192AbUJKT5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:57:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Date: Mon, 11 Oct 2004 21:58:48 +0200
User-Agent: KMail/1.6.2
Cc: Stefan Seyfried <seife@suse.de>, Pavel Machek <pavel@suse.cz>,
       ncunningham@linuxmail.org, pascal.schmidt@email.de
References: <2HO0C-4xh-29@gated-at.bofh.it> <20041011145911.GB2672@elf.ucw.cz> <416AC081.7050504@suse.de>
In-Reply-To: <416AC081.7050504@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410112158.49203.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 of October 2004 19:18, Stefan Seyfried wrote:
> Hi,
> 
> Pavel Machek wrote:
> 
> > Ok... And I guess it is nearly impossible to trigger this on demand,
> > right?

I think it is possible.  Seemingly, on my box it's only a question of the 
number of apps started.  I think I can work out a method to trigger it 90% of 
the time or so.  Please let me know if it's worthy of doing.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
