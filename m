Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144455AbRA1XkF>; Sun, 28 Jan 2001 18:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144472AbRA1Xjp>; Sun, 28 Jan 2001 18:39:45 -0500
Received: from adsl-216-102-91-127.dsl.snfc21.pacbell.net ([216.102.91.127]:22013
	"EHLO champ.drew.net") by vger.kernel.org with ESMTP
	id <S144455AbRA1Xjk>; Sun, 28 Jan 2001 18:39:40 -0500
From: Drew Bertola <drew@drewb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14964.44473.518811.451472@champ.drew.net>
Date: Sun, 28 Jan 2001 23:39:37 +0000 ()
To: drew@drewb.com
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Dieter Nützel <Dieter.Nuetzel@hamburg.de>,
        Andrew Grover <andrew.grover@intel.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.1-pre11
In-Reply-To: <14964.41681.126496.746739@champ.drew.net>
In-Reply-To: <Pine.LNX.4.10.10101281346030.4151-100000@penguin.transmeta.com>
	<3A7494B1.70799C19@mandrakesoft.com>
	<14964.41681.126496.746739@champ.drew.net>
X-Mailer: VM 6.75 under Emacs 19.34.1
Reply-To: drew@drewb.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Bertola writes:
> Andrew's latest ACPI fixes (acpica-linux-20000125 patched against
> 2.4.0) compile fine here and don't hang on my Vaio after loading
> tables.
> 
> That's a start.  I'll play around some more.

Unfortunately, pcmcia modules fail to load.  I can't understand the
interaction.  

The message displayed on boot when starting the service says:

ds: no socket drivers loaded

-- 
Drew Bertola  | Send a text message to my pager or cell ... 
              |   http://jpager.com/Drew

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
