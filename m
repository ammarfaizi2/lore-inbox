Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbTAEMf7>; Sun, 5 Jan 2003 07:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264706AbTAEMf7>; Sun, 5 Jan 2003 07:35:59 -0500
Received: from tomts9.bellnexxia.net ([209.226.175.53]:49842 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S264705AbTAEMf6>; Sun, 5 Jan 2003 07:35:58 -0500
Date: Sun, 5 Jan 2003 07:45:12 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: inconsistent xconfig menu for "Wirless LAN (non-hamradio)"
Message-ID: <Pine.LNX.4.44.0301050737500.18541-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  the menu layout under "Wireless LAN (non-hamradio)" is confusing.
i have a LinkSys WPC-11 PCMCIA card, and it took a couple reads to 
figure out what i needed to select in that submenu.

  since that card uses the hermes chipset, i naturally selected
"Hermes chipset 802.11b ...".  but wait -- a few lines down, there's
a comment, "Wireless Pcmcia/Cardbus cards support."  strange, i
could have sworn i selected something like that a few lines up
already.

  worse, even further down, there's "Hermes PCMCIA card support,"
for which the original selection has help that tells me that it was
necessary for me to select this later feature.  in that case,
if it's *required*, i shouldn't have any freedom -- the config
should select it for me.

  anyway, you the idea -- for my poor, little LinkSys WFC-11 card,
there are too many selections in that menu that seem to apply to me,
some of which should be more tightly related, or subsumed in a 
submenu.

rday

