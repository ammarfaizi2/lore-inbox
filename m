Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281292AbRKLHZm>; Mon, 12 Nov 2001 02:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281290AbRKLHZc>; Mon, 12 Nov 2001 02:25:32 -0500
Received: from palrel12.hp.com ([156.153.255.237]:18 "HELO palrel12.hp.com")
	by vger.kernel.org with SMTP id <S281292AbRKLHZX>;
	Mon, 12 Nov 2001 02:25:23 -0500
Date: Sun, 11 Nov 2001 23:26:15 -0800 (PST)
From: Grant Grundler <grundler@cup.hp.com>
Message-Id: <200111120726.XAA13975@milano.cup.hp.com>
To: omnibook@zurich.ai.mit.edu
Subject: OB600 PCMCIA - my summer vacation story
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I finally got around to writing about how I spent my summer vacation.
Well, wasn't really a vacation (4 monthes unpaid time-off from HP) 
and I did (too) many other things as well. But I did hack on OB600
PCMCIA support and ultimately didn't get it working.  I ran out of
time.  It's frustrating I can't use my ob600 as a route/firewall/
dhcp/nat server.  But I know *alot* more about PCMCIA than I did before
and that was really the goal.

If anyone has docs for the VL82C717 chip or win95 OB600SS.VXD source code,
I'm pretty sure I can make it work. With a PCMCIA bus analyzer, I might
try again...I have a 16500B with 16550 and 16510 add-on cards if
someone wants to loan me a PCMCIA pod.

In case anyone wants to hack on it further, source and notes
are on:
	ftp://gsyprf10.external.hp.com/pub/ob600/ob600_ss.c
	ftp://gsyprf10.external.hp.com/pub/ob600/notes.ob600_ss

grant
