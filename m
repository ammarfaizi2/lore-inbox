Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131387AbRBWHB0>; Fri, 23 Feb 2001 02:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbRBWHBQ>; Fri, 23 Feb 2001 02:01:16 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:52228 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S131387AbRBWHBD>; Fri, 23 Feb 2001 02:01:03 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200102230701.XAA02164@cx518206-b.irvn1.occa.home.com>
Subject: Re: PCI oddities on Dell Inspiron 5000e w/ 2.4.x
To: ttsig@tuxyturvy.com (Tom Sightler)
Date: Thu, 22 Feb 2001 23:01:14 -0800 (PST)
Cc: Jeff.Lessem@Colorado.EDU (Jeff Lessem), linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <003501c09d53$9087d000$1601a8c0@zeusinc.com> from "Tom Sightler" at Feb 22, 2001 11:45:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:
> What's strange is that I have the exact same type of machine and I don't see
> this problem, could you forward me your kernel config as well?  I'll compare
> that, and your info from your previous message to mine and see if we can
> find a difference.

Another variable, perhaps, is the BIOS version. (If you have Quick Boot or
whatever it's called enabled (which is the factory default), you'll have
to hit F2 when the "Dell" screen appears at startup, to try to enter the
BIOS setup (before Setup starts, it will show the BIOS version number and
a bunch of other stuff).)

I have a working machine, with BIOS A04. (Strangely enough, my Inspiron
5000e came with BIOS A03, and a floppy disk with A04, along with
instructions with a "do not use this BIOS flasher unless you have [some
werid video-related problem]" type of disclaimer. Since I was having those
APM oopses under Linux, I decided to try upgrading. It didn't fix the
oopses, though.)

Anyway, maybe the BIOS version is relevant to this problem as well.

-Barry K. Nathan <barryn@pobox.com>
