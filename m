Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTAEMxb>; Sun, 5 Jan 2003 07:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbTAEMxb>; Sun, 5 Jan 2003 07:53:31 -0500
Received: from [81.2.122.30] ([81.2.122.30]:17157 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S264711AbTAEMxa>;
	Sun, 5 Jan 2003 07:53:30 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301051302.h05D21DT001147@darkstar.example.net>
Subject: Re: inconsistent xconfig menu for "Wirless LAN (non-hamradio)"
To: rpjday@mindspring.com (Robert P. J. Day)
Date: Sun, 5 Jan 2003 13:02:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301050737500.18541-100000@dell> from "Robert P. J. Day" at Jan 05, 2003 07:45:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   since that card uses the hermes chipset, i naturally selected
> "Hermes chipset 802.11b ...".  but wait -- a few lines down, there's
> a comment, "Wireless Pcmcia/Cardbus cards support."  strange, i
> could have sworn i selected something like that a few lines up
> already.

In my opinion, options like that should be called "Generic Hermes
chipset 802.11b support".

>   worse, even further down, there's "Hermes PCMCIA card support,"
> for which the original selection has help that tells me that it was
> necessary for me to select this later feature.  in that case,
> if it's *required*, i shouldn't have any freedom -- the config
> should select it for me.

No, there might be a reason not to have options selected which are
"required", and that needs to be possible whichever kernel
configurator is being used.

>   anyway, you the idea -- for my poor, little LinkSys WFC-11 card,
> there are too many selections in that menu that seem to apply to me,
> some of which should be more tightly related, or subsumed in a 
> submenu.

The *best* thing to do is to make the help text more helpful, because
that way it explains the configuration to the user, instead of just
doing it for them.

John.
