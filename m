Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVARRXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVARRXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 12:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVARRXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 12:23:30 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:28178 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261389AbVARRXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 12:23:25 -0500
Date: Tue, 18 Jan 2005 18:23:22 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Paul Walker <paul@black-sun.demon.co.uk>, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>, linux-crypto@nl.linux.org,
       James Morris <jmorris@redhat.com>
Subject: Re: Announce loop-AES-v3.0b file/swap crypto package
Message-ID: <20050118172322.GH8747@pclin040.win.tue.nl>
References: <41EAE36F.35354DDF@users.sourceforge.net> <41EB3E7E.7070100@tmr.com> <41EBD4D4.882B94D@users.sourceforge.net> <1105989298.14565.36.camel@ghanima> <20050117192946.GT7782@black-sun.demon.co.uk> <1105995889.14565.47.camel@ghanima> <41ED2CD4.B0502FD7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ED2CD4.B0502FD7@users.sourceforge.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 05:35:48PM +0200, Jari Ruusu wrote:
> Fruhwirth Clemens wrote:
> > Nothing about kernel crypto is backdoored. If Ruusu thinks different, he
> > should show me source code. Till then, treat it as FUD.
> 
> I have been submitting fix for this weakness to mainline mount (part of
> util-linux package) since 2001, about 2 or 3 times a year. Refusing to fix
> it for *years* counts as intentional backdoor.
> 
> You call it whatever you want. I call it backdoor.

Hi Jari,

Your crypto is good, your language is bad.

Clearly there is no intentional backdoor.
You do not gain any credibility by saying otherwise.

Next, confusing the kernel with util-linux is a strange trick.

Finally, in the time I maintained util-linux I have asked you
I don't know how often to come with a series of small clean
patches instead of a huge ugly all-or-nothing monolithic patch.
But you didnt.

Maybe you don't understand, but it does not suffice when code
is correct - it must also be maintainable.

Something rather similar is true for the kernel, I suspect.
A series of short clean patches would have solved all problems.

As it is, time may be running out - some years ago your stuff
was far superior to everything else. But alternative
approaches are being developed, and maybe loop-aes will soon
be some historic oddity.

Andries

