Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVAFRzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVAFRzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVAFRzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:55:20 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:53123 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262948AbVAFRya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:54:30 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm2: swsusp regression
Date: Thu, 6 Jan 2005 18:48:11 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <20050106002240.00ac4611.akpm@osdl.org>
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501061848.11719.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 6 of January 2005 09:22, Andrew Morton wrote:
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
> 
> - Various minorish updates and fixes

There's an swsusp regression on my box (AMD64) wrt -mm1.  Namely, 2.6.10-mm2 
does not suspend, but hangs solid right after the critical section, 100% of 
the time.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
