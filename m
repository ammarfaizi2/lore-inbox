Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUDLLGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 07:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUDLLGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 07:06:50 -0400
Received: from mail.gmx.de ([213.165.64.20]:2449 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262850AbUDLLGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 07:06:47 -0400
X-Authenticated: #11437207
Date: Mon, 12 Apr 2004 14:09:43 +0200
From: Tim Blechmann <TimBlechmann@gmx.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ivica Ico Bukvic <ico@fuse.net>, "'Thomas Charbonnel'" <thomas@undata.org>,
       daniel.ritz@gmx.ch, ccheney@debian.org,
       linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion
 -- FIXED!
Message-Id: <20040412140943.372004be@laptop>
In-Reply-To: <20040412113904.A11076@flint.arm.linux.org.uk>
References: <200404120145.22679.daniel.ritz@gmx.ch>
	<20040412013949.NJOP1634.smtp3.fuse.net@64BitBadass>
	<20040412130236.66a86b50@laptop>
	<20040412113904.A11076@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only the first 0x48 registers are defined by the base specification;
> the rest are chip and/or manufacturer specific.
i see ...

> The registers which Ico is changing are specific to the ENE CB1410,
> which are a clone of the TI chips.
> 
> Your cardbus bridge isn't a clone of TI, so I wouldn't expect the
> same fix to work for you.
:-(
do you want me to install windows and have a look at my register settings on a working setup? since my problem might be a different one, i just want to make sure that its neccessary that i install windows ... i'd have to back up a lot of stuff, so it would take some time...
 
> PS, in your first mail I have on this subject, you mentioned someone
> called "Timothy" who had the same problem, and was using Red Hat with
> a TI bridge.  I don't seem to have any responses from him, and it i forwarded this mail to him ... i hope he will respond, soon...

cheers...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac

