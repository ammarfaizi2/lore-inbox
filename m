Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131839AbQK2Vpa>; Wed, 29 Nov 2000 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131479AbQK2VpU>; Wed, 29 Nov 2000 16:45:20 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:35981 "EHLO
        yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
        id <S131438AbQK2VpE>; Wed, 29 Nov 2000 16:45:04 -0500
From: James A Sutherland <jas88@cam.ac.uk>
To: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fasttrak100 questions...
Date: Wed, 29 Nov 2000 21:10:06 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        "Henning P. Schmiedehausen" <hps@tanstaafl.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011291300470.1743-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10011291300470.1743-100000@master.linux-ide.org>
MIME-Version: 1.0
Message-Id: <00112921145000.11020@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Andre Hedrick wrote:
> On Wed, 29 Nov 2000, Alan Cox wrote:
> 
> > > You are wrong: If you modify the kernel you have to make it available for
> > > anyone who wishes to use it; that's also in the GPL. You can't add stuff
> > 
> > No it isnt. Some people seem to think it is. You only have to provide a 
> > change if you give someone the binaries concerned. Some people also think
> > that 'linking' clauses mean they can just direct the customer to do the link,
> > that also would appear to be untrue in legal precedent - the law cares about
> > the intent.
> 
> Of the list of poeple here, only Alan was present with the discussion of
> the terms of how the FASTTRAK SCSI-Emulation API to ATA was defined.
> Since you are not in the position to define the terms of how the
> interaction between the two subsystems work, you have no clue that
> building it into the kernel will fail!
> 
> Second read the causes about "COMMERIAL INTENT", somewhere around section
> 7 paragraph 3.

Section 7 paragraph 3 relates to patent infringement. The GNU WWW site is
extremely clear on this issue:

"You should also have the freedom to make modifications and use them privately
in your own work or play, without even mentioning that they exist."
(http://www.gnu.org/philosophy/free-sw.html). No restrictions are imposed in
the GPL; none are intended, according to the FSF.

[jas88@dax linux-2.4.0-test11.vanilla]$ grep -i --context=3 commercial COPYING
 
    c) Accompany it with the information you received as to the offer
    to distribute corresponding source code.  (This alternative is
    allowed only for noncommercial distribution and only if you
    received the program in object code or executable form with such
    an offer, in accord with Subsection b above.)

That's the only occurrence of the word "commercial" in the GPL.

> I have defined the terms that are acceptable to a binary module that
> incorporates GPL code of MINE!  This I DEFINE THE TERMS, and they are
> module only!

Nope. RMS defined the terms which apply to GPL code. You are free to define any
other terms you like for your own code, but it is no longer GPLed in that case.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
