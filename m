Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWH1FRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWH1FRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 01:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWH1FRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 01:17:34 -0400
Received: from 8.ctyme.com ([69.50.231.8]:8900 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932292AbWH1FRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 01:17:33 -0400
Message-ID: <44F27C6C.30709@perkel.com>
Date: Sun, 27 Aug 2006 22:17:32 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You might want to look at this bug.

http://bugzilla.kernel.org/show_bug.cgi?id=6975

The current kernel doesn't run on Asus Motherboards that use the new AM2 
CPUs. Should this be addressed before 2.6.18 is finished?

