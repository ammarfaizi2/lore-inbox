Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135277AbRDZK0L>; Thu, 26 Apr 2001 06:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135281AbRDZK0C>; Thu, 26 Apr 2001 06:26:02 -0400
Received: from mail.informatik.uni-ulm.de ([134.60.68.63]:61972 "EHLO
	mail.informatik.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S135277AbRDZKZo>; Thu, 26 Apr 2001 06:25:44 -0400
Message-ID: <3AE7F794.220E905C@student.uni-ulm.de>
Date: Thu, 26 Apr 2001 12:25:24 +0200
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
Organization: University of Ulm
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: de,de-DE,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: The further way? (was: Re: AHA-154X/1535 not recognized any more)
In-Reply-To: <3AE56932.A62BF389@student.uni-ulm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Markus Schaber wrote:
[some Test results]

So what's the further way to go?

We found out that the kernel isapnp fails, while the isapnptools (with
"check" entry removed and the driver as a module) and a non-pnp
environment (where the BIOS initialzies it, and either a modularized and
a compiled in driver) work with this card.

Do I (as a non-kernel-hacker, and with only basic C experience) have any
chance to quickly read into the code and find and correct the bug? Or is
there anyone around here who just needs five minutes to adjust a few
lines?

As I said, I don't need the card any more, and am just waiting for this
thing to be resolved, and then I remove this ancient thing. I could even
send it to one of you per snail mail for some weeks to let you do
further tests. My intention was to give a possibility to get the bug
fixed :-)

markus
-- 
Markus Schaber -- http://www.schabi.de/ -- ICQ: 22042130
+-------------------------------------------------------------+
| Allgemeine Sig-Verletzung 0815/4711  <nicht OK> <Erbrechen> |
+-------------------------------------------------------------+
