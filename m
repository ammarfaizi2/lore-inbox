Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBXF2P>; Sat, 24 Feb 2001 00:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBXF2F>; Sat, 24 Feb 2001 00:28:05 -0500
Received: from web9210.mail.yahoo.com ([216.136.129.43]:15621 "HELO
	web9210.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129106AbRBXF1w>; Sat, 24 Feb 2001 00:27:52 -0500
Message-ID: <20010224052747.33042.qmail@web9210.mail.yahoo.com>
Date: Fri, 23 Feb 2001 21:27:47 -0800 (PST)
From: bradley mclain <bradley_kernel@yahoo.com>
Subject: Re: APM suspend system lockup under 2.4.2 and 2.4.2ac1
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14WJrt-0006Ud-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i thought that it was my network driver, but i
recompiled 2.4.2 without sound support and apm
--suspend has begun to work again.

the sound card is a yamaha YMF-744B.  i hadn't been
compiling with sound support (i dont care about sound
on my laptop), but when i got 2.4.2 i decided to try,
and now i'm pretty sure that was the problem.

is there anything else i should do, or information i
could provide that would confirm this analysis or help
to find a fix?

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Can you see if 2.4.1ac20 was ok
> 


__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
