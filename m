Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUJBUCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUJBUCy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 16:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUJBUCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 16:02:54 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:10948 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267527AbUJBUCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 16:02:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp: fix x86-64 suspend in -rc3
Date: Sat, 2 Oct 2004 22:05:11 +0200
User-Agent: KMail/1.6.2
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20041002163446.GA22585@elf.ucw.cz>
In-Reply-To: <20041002163446.GA22585@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410022205.12074.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 of October 2004 18:34, Pavel Machek wrote:
> Hi!
> 
> Try this one, tell me if it helps.
[--snip --]

It apparently does.  I have successfully suspended and resumed the box for 
five or six times in a row (I've lost the count ;-)).  It's _much_ better 
than it used to be!  Of course I will torment it further and I'll let you 
know if anything goes wrong.

Thanks a lot for the great job!

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
