Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSK0C7t>; Tue, 26 Nov 2002 21:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSK0C7t>; Tue, 26 Nov 2002 21:59:49 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:37577 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S261418AbSK0C7t>; Tue, 26 Nov 2002 21:59:49 -0500
Date: Tue, 26 Nov 2002 22:06:33 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: 2.4.20-rc4-ac1 SiS IDE driver troubles
Message-ID: <20021127030633.GA1642@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P4S533 (SiS645DX chipset)
P4 2GHz
1G PC2700 RAM

After booting and initscripts I get some kind of error like a BUG() but
I can't see what it is because it scrolls off with repeated "unable to
handle kernel paging request" messages. The first error shows a stack trace
(briefly) but all the rest just show the offsets without the text.

If I choose just Generic IDE then I can boot (of course I don't get to
use ATA/133). No mouse, but since that error has been there since 2.4.20
pre8 I'm pretty sure it's not related.

There are no error messages in the logs - just a long series of <nul>
where the messages would be.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

