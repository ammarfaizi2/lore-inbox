Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSF2BNE>; Fri, 28 Jun 2002 21:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSF2BNE>; Fri, 28 Jun 2002 21:13:04 -0400
Received: from sendmail.avnet.com ([12.9.139.96]:41192 "EHLO ipa.avnet.com")
	by vger.kernel.org with ESMTP id <S317491AbSF2BND>;
	Fri, 28 Jun 2002 21:13:03 -0400
Message-ID: <C08678384BE7D311B4D70004ACA371050B763539@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'David Weeks'" <dweeks02@tampabay.rr.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Twister chipset... other stuff...  sheesh...
Date: Fri, 28 Jun 2002 18:15:17 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, if you are ctags'ing the kernel source tree,
then you get tags for all the architectures etc.
which is probably more than you want.
The Linux kernel source tree has a nice "make tags"
command you can use, which is set up to run ctags
only on your current architecture. -> smaller tags
file, and fewer multiple matches.  For me, this
is 42 MB (ctags -R) vs. 13 MB (make tags).

Also, you shouldn't (TM) have to search the tags
file yourself.  Emacs & vi & vim have commands such
as "show me the file this symbol is in", with just
a few keystrokes, and the editor will do the grunt
work of searching the tags file for you, as well as
getting you back where you came from ("tag stack").
All you have to do is tell the editor where the tags
file is. (Sorry to be vague on *how*, but I'm a vim
user & so I can't tell you the syntax for Emacs.)



-----Original Message-----
From: David Weeks [mailto:dweeks02@tampabay.rr.com]
Sent: Friday, June 28, 2002 5:35 PM
To: Kerl, John
Cc: linux-kernel@vger.kernel.org
Subject: Twister chipset... other stuff... sheesh...


OK,

I ctags -R the source tree, getting a 28meg tag file, and searched it in 
emacs.

Sheeshhsh...  I've got a dotcom network to admin., php/postgres/ssh apps to 
develop, and all the business crap needed to "run" a business to deal with.

(you know, all that gov crap that's got nothing to do with making YOUR OWN 
living.)

Basically I want to use this laptop as a proof of concept demo to all the 
un-free masses out there who think linux is bad cause (Apple using) Rush 
Limbaugh sez so.  But a laptop with NO power management and NO sound is the 
proof of concept the Evil people would like me to show.


This sucks.

John, thanks for the ctags tip.  It helped now, and will even more in the 
future.  

Dave

PS -- I'm damned tired of manufactures NOT supporting us.  Are we a market
or 
not?
-- 
dweeks02@tampabay.rr.com
813-236-2009
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
