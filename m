Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318798AbSHLTmM>; Mon, 12 Aug 2002 15:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318799AbSHLTmM>; Mon, 12 Aug 2002 15:42:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34207 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318798AbSHLTmM>;
	Mon, 12 Aug 2002 15:42:12 -0400
Date: Mon, 12 Aug 2002 12:32:27 -0700 (PDT)
Message-Id: <20020812.123227.43644092.davem@redhat.com>
To: ohrn@chl.chalmers.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: sungem 0.97 driver doesn't work with "Sun GigabitEthernet/P
 2.0" card.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208122129030.17687-100000@feline.chl.chalmers.se>
References: <Pine.LNX.4.44.0208122129030.17687-100000@feline.chl.chalmers.se>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No, doing the test from solaris/Sparc isn't going to work.

You're trying this on an x86 system right?  If so that's the crux of
the problem, you need to dump the PCI resources from Linux for some
x86 wizard to look at.
