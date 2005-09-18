Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVIRURg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVIRURg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 16:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVIRURg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 16:17:36 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:37848 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S932186AbVIRURf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 16:17:35 -0400
Message-ID: <432DCBCC.3050706@cs.aau.dk>
Date: Sun, 18 Sep 2005 22:19:24 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Sniffing PCI bus
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to get some information on a card plugged on a PCI bus.
The driver exist only for Windows, so I try to spy the PCI bus under
Windows XP and trying to get the content of the commands to the chipset
of the card.

I am using this Windows PCI sniffer (with the -D option):
http://members.datafast.net.au/~dft0802/downloads.htm

Unfortunately, whatever I do with the card, I only get one type of
memory image (the one displayed when the card is uninitialized).

So, I guess I do something wrong.

Does anybody get some experience in PCI sniffing under Windows XP ?
What are the good softwares to use, the tricks to know, etc.

Any help is welcome.

Just for your interest, the chipset that I'm trying to analyse is this
one: http://r-engine.sourceforge.net/

Regards
-- 
Emmanuel Fleury

The optimist proclaims that we live in the best of all possible worlds;
And the pessimist fears this is true.
  -- James Branch Cabell
