Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWI3HG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWI3HG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 03:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWI3HG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 03:06:59 -0400
Received: from dp.samba.org ([66.70.73.150]:57474 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S1751104AbWI3HG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 03:06:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17694.5933.159694.454938@samba.org>
Date: Sat, 30 Sep 2006 17:05:17 +1000
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <1159559443.9543.23.camel@mulgrave.il.steeleye.com>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	<17692.46192.432673.743783@samba.org>
	<1159515086.3880.79.camel@mulgrave.il.steeleye.com>
	<17692.57123.749163.204216@samba.org>
	<1159559443.9543.23.camel@mulgrave.il.steeleye.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

 > Well, this is the whole point.  Today, you can distribute GPLv2 packages
 > without much patent worry ... if you develop GPLv2 packages, that's
 > different, but if you simply act as a conduit, you're not going to have
 > too much trouble.

I just can't see where you get this interpretation of the GPLv2
from. The wording in GPLv2 is:

  If you cannot distribute so as to satisfy simultaneously your
  obligations under this License and any other pertinent obligations,
  then as a consequence you may not distribute the Program at all.
  For example, if a patent license would not permit royalty-free
  redistribution of the Program by all those who receive copies
  directly or indirectly through you, then the only way you could
  satisfy both it and this License would be to refrain entirely from
  distribution of the Program.

It specifically says "distribute" (4 times in fact). It specifically
says that all people, direct or indirect must be able to redistribute
royalty free, or you have to refrain from distributing.

It never mentions the word develop in the license text (only in the
"how to apply these terms to your program" section).

I just can't see how any lawyer, especially one trying to be cautious
about their companies potential liability, could try to claim that the
above paragraph doesn't apply to distribution.

Do you really have a solid legal opinion that the above paragraph from
GPLv2 doesn't apply when distributing? If so, could you ask the lawyer
to explain the argument? I know legal interpretations can sometimes be
tortuous, but to read the above without it applying to distribution
seems far too much of a stretch.

Cheers, Tridge
