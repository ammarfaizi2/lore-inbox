Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSFLF0L>; Wed, 12 Jun 2002 01:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317588AbSFLF0K>; Wed, 12 Jun 2002 01:26:10 -0400
Received: from [64.35.113.47] ([64.35.113.47]:48145 "HELO u1.name2host.com")
	by vger.kernel.org with SMTP id <S317582AbSFLF0J>;
	Wed, 12 Jun 2002 01:26:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adam Luchjenbroers <adam@luchjenbroers.com>
Reply-To: adam@luchjenbroers.com
To: linux-kernel@vger.kernel.org
Subject: Parallel Port and USB Device Drivers
Date: Wed, 12 Jun 2002 14:58:54 +0930
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020612052609Z317582-22020+2716@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone tell me where I can find some documentation regarding 
implementing LPT and USB device drivers.

Also, is it possible to have a function called timed to the LPT output (since 
LPT data rates are very slow it would be more efficient for the driver to be 
called when the port is ready to output the next byte instead of having it 
perform a few delay loops).

Any information regarding how I'd go about building these drivers as kernel 
modules would be nice.

And just a quick theoretical question.

How does the Linux kernel cope with the Pentium 4 clock throttling feature 
given that it uses bogomips for timing purposes?

