Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbTJAWGd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTJAWGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:06:33 -0400
Received: from gprs150-56.eurotel.cz ([160.218.150.56]:24705 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262555AbTJAWG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:06:29 -0400
Date: Thu, 2 Oct 2003 00:05:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Radu Filip <socrate@infoiasi.ro>
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Makan Pourzandi <Makan.Pourzandi@ericsson.ca>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification for binaries
Message-ID: <20031001220532.GD5289@elf.ucw.cz>
References: <20031001182440.GV7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310020043550.16234-100000@shrek.tuiasi.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310020043550.16234-100000@shrek.tuiasi.ro>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > <shrug> so in a month rootkits get updated and we are back to square 1,
> > with additional mess from patch...
> 
> Viro, I think you have an attitude problem here. "Don't be ridiculous",
> "Rubbish", "<shrug>" don't sound very constructive or at least
> encouraging.
> 
> Over the years it was proved that Linux kernel can be tailored for a very
> large number of unexpected and very strange needs. IBM put it into
> watches, NASA sent it to space, it is exists in oil wells and so on. I
> think that the possibilities offered by Linux kernel are limited only by
> the knowledge, imagination and will of every of us. Linux itself was once
> a very insignificant and unreliable kernel and many other serious Unix and
> Unix-like alternative were available. Still, it is prevailing today because
> some peoples believed in what they did.
> 
> Especially to your point, should I mention that there are patches that
> avoid buffer-overflows? Or that there are patches for gcc that add bound
> check to arrays in C?

I simply wanted to see valid usage of this. It certainly does not
prevent attacker to get control of your box. Al seems to be right. It
may temporarily redirect script-kiddies, through...

There may be some uses like "prevent tivo users from running their own
software", but I'm not sure I want to encourage some uses. Maybe "its
neccessary to get our phones approved by FCC" would be better.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
