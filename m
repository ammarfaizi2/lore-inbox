Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWCRMmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWCRMmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 07:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWCRMmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 07:42:46 -0500
Received: from mail.linicks.net ([217.204.244.146]:36776 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751474AbWCRMmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 07:42:45 -0500
From: Nick Warne <nick@linicks.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: chmod 111
Date: Sat, 18 Mar 2006 12:42:24 +0000
User-Agent: KMail/1.9.1
Cc: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@osdl.org>,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>,
       linux-kernel@vger.kernel.org
References: <200603171746.18894.nick@linicks.net> <1142621728.9478.20.camel@localhost.localdomain> <Pine.LNX.4.61.0603172243460.829@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603172243460.829@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603181242.24619.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 21:44, Jan Engelhardt wrote:
> >Yep, I agree whole heartily.  I should have stressed the "little" part
> >in the above quote. "might make your system a __little__ more secure.".
>
> -rws--x--x  1 root root 1847788 Sep 16 14:58 /usr/X11R6/bin/Xorg
>
> I never could figure out what this permission mask was good for.

Yes, my post was initiated by a question in this months RH magazine - somebody 
asked why 'finger' on RH systems was chmod 0711 and how/why ordinary users 
could still run it.  Shadowman didn't know and I was stumped too.

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
