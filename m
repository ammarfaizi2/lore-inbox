Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282902AbSAMKIc>; Sun, 13 Jan 2002 05:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287984AbSAMKIX>; Sun, 13 Jan 2002 05:08:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43270 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S282902AbSAMKIJ>; Sun, 13 Jan 2002 05:08:09 -0500
Date: Sun, 13 Jan 2002 11:08:09 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Stuck Ethernet
Message-ID: <20020113100809.GA12975@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an point-to-point full-duplex link over free-space optical transceiver.
When the link gets broken and is then reestablished, sometimes it is necessary
to reboot my computer to get it working again, although the link is physically
clear. The transceiver contains no intelligence so the problem is not in it
(it's just a bunch of amplifiers and stateless digital circuitry).

I suspect something nasty going about arp, but could you please advise me where
to find the problem? I have got 2.4.13-ac8, 3c509B ISA NIC with AUI set to
full-duplex.

Clock
