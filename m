Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbTEHWd3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbTEHWd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:33:29 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:28300 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262192AbTEHWdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:33:05 -0400
Date: Thu, 8 May 2003 23:36:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030508213601.GC4466@elf.ucw.cz>
References: <20030506164252.GA5125@mail.jlokier.co.uk> <1052242508.1201.43.camel@dhcp22.swansea.linux.org.uk> <20030506185433.GA6023@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506185433.GA6023@mail.jlokier.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > So, as dynamic loading is ok between parts of Linux and binary-only
> > > code, that seems to imply we could build a totally different kind of
> > > binary-only kernel which was able to make use of all the Linux kernel
> > > modules.  We could even modularise parts of the kernel which aren't
> > > modular now, so that we could take advantage of even more parts of Linux.
> > 
> > You want a legal list - you really do. Its all about derived works and
> > thats an area where even some lawyers will only hunt in packs 8)
> 
> Alan, you're right of course - from a legal standpoint.  But I'm not
> interested in how it pans out in a strict legal interpretation.
> 
> What I'm interested in is how the kernel developers and driver authors
> would treat something like that.  Binary modules haven't had the full
> lawyer treatment AFAIK, but a sort of community viewpoint regarding
> what is and is not acceptable, to the community, is fairly clear on
> this list.
> 
> So I was wondering what is the community viewpoint when it's the
> core kernel that is a non-GPL binary, rather than the modules.
> 
> What if this new-fangled other kernel is open source, but BSD
> license

If you took vicam driver and made it ran under Windows XP, it would be
okay. (It uses defined interface after all). I do not see why vicam
driver under "your own os" would be different.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
