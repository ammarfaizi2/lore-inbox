Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131718AbRCQRSl>; Sat, 17 Mar 2001 12:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131715AbRCQRSc>; Sat, 17 Mar 2001 12:18:32 -0500
Received: from imladris.infradead.org ([194.205.184.45]:37902 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S131718AbRCQRSX>;
	Sat, 17 Mar 2001 12:18:23 -0500
Date: Sat, 17 Mar 2001 17:17:22 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.CX>
To: <Andries.Brouwer@cwi.nl>
cc: <kaboom@gatech.edu>, <linux-kernel@vger.kernel.org>,
        <seberino@spawar.navy.mil>
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <UTC200103170107.CAA06282.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0103171052180.15572-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries.

 >> {Shrug} Thinking isn't sufficient - check your facts.

 > Poor Riley,
 >
 > Probably I should not answer, I think you know all the facts
 > already. But just to be sure:

 > (i) There are two different packages, kbd and a forked version,
 > console-tools. Both contain roughly the same programs. In your
 > earlier mails you seemed aware of that, but now you report that
 > the console-tools version of loadkeys does not want to print a
 > kbd version. No surprise there.

You make claims for me there that I've never made, so can I suggest
you get your facts right this time. For reference:

 1. My claim was NOT that the loadkeys from console-tools does
    not print a kbd version, as you claim in the comment quoted
    above. I claimed that it doesn't print ANY version, including
    one for loadkeys itself.

 2. YOUR claim was that the loadkeys command ALWAYS displays the
    version number, so the command in ver_linux is thus always
    guaranteed to produce a version number. MY claim was that
    at least one loadkeys command fails to do so, and thus that
    one can't expect it to do so.

Thank you for confirming that your claim was false.

 > (ii) I am the maintainer of both mount and util-linux.
 > If I say that there exists no more recent version of mount
 > than the one found in util-linux, you can believe me.

Neither of us has claimed otherwise, nor have we been disputing that.

YOUR claim was that all systems always have the same version of mount
and util-linux installed, even when they are from different packages.
MY claim was that no such guarantee can be given, as it's possible for
somebody to upgrade either without upgrading the other when they are
supplied separately.

Again, thank you for confirming that your claimwas false.

Best wishes from Riley.

