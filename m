Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132121AbRDPWYS>; Mon, 16 Apr 2001 18:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRDPWYJ>; Mon, 16 Apr 2001 18:24:09 -0400
Received: from mail.gci.com ([205.140.80.57]:39697 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S131643AbRDPWXv>;
	Mon, 16 Apr 2001 18:23:51 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA3150446D9FC@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: esr@snark.thyrsus.com, linux-kernel@vger.kernel.org
Subject: Re: CML2 1.1.3 release announcement
Date: Mon, 16 Apr 2001 14:23:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.

Looking better -

I'm in the process of configuring v2.4.3..

It looks as if the TUN/TAP selection isn't being grok'd right.
It should be available as a module, yet the 'm' is greyed out and
not selectable.  I don't see any prerequistes in the drivers/net/rules.cml
either, although i'm not exactly proficient at reading these yet..

if the functionality of tun/tap as a module has been removed, perhaps the
help text should also be updated, but CML1 does allow me to select it as
a module..


As far as the colors go, it never really bothers me, although my color-blind
friend my have some input -- but he's out sick with pink-eye.

(okay, not pink-eye, but that just sounded funny for a color-blind person)

Leif
