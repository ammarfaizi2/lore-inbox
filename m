Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273611AbTHKTs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273906AbTHKTsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:48:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:41139 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S273611AbTHKTsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:48:53 -0400
Date: Mon, 11 Aug 2003 12:46:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: M M <mokomull@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test3: make modules; make modules_install problems
Message-Id: <20030811124600.2fb5b263.rddunlap@osdl.org>
In-Reply-To: <20030811192453.51395.qmail@web41811.mail.yahoo.com>
References: <20030811192453.51395.qmail@web41811.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 12:24:53 -0700 (PDT) M M <mokomull@yahoo.com> wrote:

| I have downloaded kernel 2.6.0-test3 sources twice (in
| case of error) and the problem still persists.  'make
| modules' compiles the modules to *.o, but 'make
| modules_install' expects them to be *.ko.  Am I the
| only one with this problem or does everyone have this
| problem?

I don't see that.

--
~Randy				For Linux-2.6, see:
http://www.kernel.org/pub/linux/kernel/people/davej/misc/post-halloween-2.5.txt
