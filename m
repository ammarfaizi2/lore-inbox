Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWA2Oaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWA2Oaf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 09:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWA2Oaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 09:30:35 -0500
Received: from main.gmane.org ([80.91.229.2]:17549 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751008AbWA2Oae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 09:30:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Sun, 29 Jan 2006 15:30:19 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2006.01.29.14.30.16.953762@smurf.noris.de>
References: <43D114A8.4030900@wolfmountaingroup.com> <20060120111103.2ee5b531@dxpl.pdx.osdl.net> <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com> <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <43D9F9F9.5060501@ti-wmc.nl> <Pine.LNX.4.64.0601272333070.2909@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus Torvalds wrote:

> And that's really what I don't like. I believe that a software license 
> should cover the software it licenses, not how it is used or abused - even 
> if you happen to disagree with certain types of abuse.
> 
> I believe that hardware that limits what their users can do will die just 
> becuase being user-unfriendly is not a way to do successful business. Yes, 
> I'm a damned blue-eyed optimist

There's one problem with your approach. I probably agree with you about
the dying-out part, in th long term, BUT that leaves the current owners of
said hardware out in the cold.

Say I buy a FooBox. It's advertized as running Linux and foos reasonably
enough, thank you, but I'd like it to bar too, so I want to build a new
kernel and upload it to my box, thereby turning my FooBox into a
FooBarBox. Or maybe there's a bug, and the vendor says "no big deal"
(and I disagree).

I have a reasonable expectation to be able to do so. That's what free
software is all about (among other things). But if the box requires some
TPMish keysigning to be fed with an update, my system has just turned into
an expensive doorstop and/or I have no recourse, and no legal rights WRT
the vendor, whatsoever.

It's perfectly OK if the *owner* of the box says I can't do that and won't
give me the key (say, I'm an employee and the box is not supposed to run
stuff the IT honchos don't like). BUT NOT FOR ANYBODY ELSE.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Make it idiot-proof, and someone will breed a better idiot.
	-- Oliver Elphick


