Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbRGFPRp>; Fri, 6 Jul 2001 11:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266729AbRGFPRf>; Fri, 6 Jul 2001 11:17:35 -0400
Received: from [216.151.155.121] ([216.151.155.121]:9485 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S266728AbRGFPRa>; Fri, 6 Jul 2001 11:17:30 -0400
To: landley@webofficenow.com
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: The SUID bit (was Re: [PATCH] more SAK stuff)
In-Reply-To: <200107060145.f661j5v74941@saturn.cs.uml.edu>
	<01070606044004.00596@localhost.localdomain>
From: Doug McNaught <doug@wireboard.com>
Date: 06 Jul 2001 11:17:28 -0400
In-Reply-To: Rob Landley's message of "Fri, 6 Jul 2001 06:04:40 -0400"
Message-ID: <m3u20q6q9j.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@webofficenow.com> writes:

> Do you have a code example of how a program with euid root can change its 
> actual uid (which several programs check when they should be checking euid, 
> versions of dhcpcd before I complained about it case in point)?

Ummm...  setuid(2)?

Works for me...

-Doug
-- 
The rain man gave me two cures; he said jump right in,
The first was Texas medicine--the second was just railroad gin,
And like a fool I mixed them, and it strangled up my mind,
Now people just get uglier, and I got no sense of time...          --Dylan
