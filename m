Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136552AbRAMF2h>; Sat, 13 Jan 2001 00:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136568AbRAMF21>; Sat, 13 Jan 2001 00:28:27 -0500
Received: from web5204.mail.yahoo.com ([216.115.106.85]:37390 "HELO
	web5204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S136552AbRAMF2O>; Sat, 13 Jan 2001 00:28:14 -0500
Message-ID: <20010113052809.24146.qmail@web5204.mail.yahoo.com>
Date: Fri, 12 Jan 2001 21:28:09 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: BUG in 2.4.0: dd if=/dev/random of=out.txt bs=10000 count=100
To: david+validemail@kalifornia.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Ford <david@linux.com> wrote:
> Rob Landley wrote:
> 
> > If I do the dd line in the title under 2.4.0 I get
> an
> > out.txt file of 591 bytes.
> 
> It isn't broken, you have no more entropy.  You must
> have some system
> activity of various sorts before you regain some
> entropy.  Moving the mouse
> around, hitting keys, etc, will slowly add more
> entropy.
> 
> -d

I'd wondered what urandom was for.  Thanks.

Rob


__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
