Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277191AbRJINRg>; Tue, 9 Oct 2001 09:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277187AbRJINRY>; Tue, 9 Oct 2001 09:17:24 -0400
Received: from [195.66.192.167] ([195.66.192.167]:39175 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S277192AbRJINRL>; Tue, 9 Oct 2001 09:17:11 -0400
Date: Tue, 9 Oct 2001 16:16:34 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <163112682879.20011009161634@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: kernel size
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

I recompiled my kernel with GCC 3.0.1 (was 2.95.x)
and guess what - it got bigger...
Somehow, I hoped in linux world software gets better
with time, not worse...

Maybe that's my fault (misconfigured GCC etc) ?
What do you see?

Being curious, I looked into vmlinux (uncompressed kernel).
I saw swatches of zero bytes in places, large repeateable
patterns etc. You may look there too in your spare time.

Especially informative are two pages (my console:100x40)
filled with "GCC: (GNU) 3.0.1". Does this gets into
unswappable memory when kernel loads?
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


