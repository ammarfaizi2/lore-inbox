Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWBDT3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWBDT3j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWBDT3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:29:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50398 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932547AbWBDT3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:29:38 -0500
Date: Sat, 4 Feb 2006 20:29:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060204192924.GC3909@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602041120.59830.nigel@suspend2.net> <20060204090112.GJ3291@elf.ucw.cz> <200602041954.22484.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602041954.22484.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > [Pavel is willing to take patches, as his cooperation with Rafael
> > > > shows, but is scared by both big patches and series of 10 small
> > > > patches he does not understand. He likes patches removing code.]
> > >
> > > Assuming you're refering to the patches that started this thread, what
> > > don't you understand? I'm more than happy to explain.
> >
> > For "suspend2: modules support", it is pretty clear that I do not need
> > or want that complexity. But for "refrigerator improvements", I did
> 
> ... and yet you're perfectly happy to add the complexity of sticking half 
> the code in userspace. I don't think I'll ever dare to try to understand 
> you, Pavel :)

Complexity in userspace: ungood.

Complexity in kernel: doubleplusungood.

It is not that hard to understand :-).
								Pavel

-- 
Thanks, Sharp!
