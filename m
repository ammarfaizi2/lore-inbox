Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTKTGz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 01:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTKTGz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 01:55:29 -0500
Received: from [202.81.18.30] ([202.81.18.30]:9496 "EHLO gaston")
	by vger.kernel.org with ESMTP id S261586AbTKTGzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 01:55:25 -0500
Subject: Re: Announce: ndiswrapper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
In-Reply-To: <20031120052659.GF22764@holomorphy.com>
References: <20031120031137.GA8465@bougret.hpl.hp.com>
	 <3FBC3483.4060706@pobox.com> <20031120040034.GF19856@holomorphy.com>
	 <3FBC5036.3020503@pobox.com>  <20031120052659.GF22764@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1069311243.5185.192.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 20 Nov 2003 17:54:04 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > ndiswrapper has one use IMHO (which was pointed out me in this 
> > thread)... to assist in reverse engineering.
> 
> Hmm, maybe I've gotten the whole purpose of the thread wrong. =(

Still, I've looked into possibly reverse engineering the Broadcom
one for 802.11g from MacOS X (with 2 machines kernel debugging and
functions names embedded in the driver, it's not _that_ bad). But
it's a +500k binary .... I didn't go very far and decided I had
better ways to spend my time.

I know a lot of you don't care, but I hate in those discussions
about binary drivers when what is for me the #1 issue isn't even
mentioned: availability on non-x86 hardware !

Ben.

