Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272135AbTG2VrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 17:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272133AbTG2VrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 17:47:09 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:36507 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S272219AbTG2VrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 17:47:05 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Jan Huijsmans <kernel@koffie.nu>
Date: Tue, 29 Jul 2003 23:46:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.0-test 2 & matroxfb or orinoco wifi card
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <8A4F5113786@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 03 at 23:31, Jan Huijsmans wrote:
> On 29-Jul-2003 Petr Vandrovec wrote:
> > On 29 Jul 03 at 22:35, Jan Huijsmans wrote:
> >> After digging a bit in the archives I couldn't find the solution to my
> >> problem, so I'm asking you guys.
> > It is bug in matroxfb. I sent patch to Linus already, but it did not found
> > its way through his email filters yet. I'll try again...
> 
> Hmmm, I found the patch, but that didn't help. (I suspect you're talking about
> the matroxfb-2.5.72 patch mentioned on the list)

No, I was talking about URL I gave you - matroxfb-novt.gz.

matroxfb-2.5.72 does completely different things, and in your headless
and keyboardless situation it can make situation only worse.

> I found the keyboard setting, after which the VT support came available. Wierd
> that I didn't find it myself, as my laptop has no problems with 2.6 (accept
> that I need to recompile the pcmcia package) and it's not using a framebuffer.

I do not believe that you are using your laptop without keyboard and you
did not notice it yet.
                                                Petr
                                                

