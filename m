Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSBJSu7>; Sun, 10 Feb 2002 13:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289730AbSBJSuu>; Sun, 10 Feb 2002 13:50:50 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:57784 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289727AbSBJSud>; Sun, 10 Feb 2002 13:50:33 -0500
X-From-Line: nobody Sun Feb 10 15:35:58 2002
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <Pine.LNX.4.33.0202092211001.10024-100000@home.transmeta.com>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Sun, 10 Feb 2002 15:35:57 +0100
Message-ID: <87k7tlqu9e.fsf@tigram.bogus.local>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Sat, 9 Feb 2002, Andrew Morton wrote:
>> I'm showing thirteen header files, for a total of 83k.  I'll do something
>> about this...
>
> Ok, so even your gcc obviously is _not_ intelligent enough to throw away
> strings from inline functions that aren't used. Oh well.

Try using gcc 3.x. Or is this a not an option with linux right now?

Regards, Olaf.
