Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSKCMSz>; Sun, 3 Nov 2002 07:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbSKCMSz>; Sun, 3 Nov 2002 07:18:55 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:24716 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261806AbSKCMSy>; Sun, 3 Nov 2002 07:18:54 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Werner Almesberger <wa@almesberger.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <20021102234344.I2599@almesberger.net>
References: <Pine.LNX.4.44.0211021619580.2221-100000@home.transmeta.com>
	<1036286840.18289.2.camel@irongate.swansea.linux.org.uk> 
	<20021102234344.I2599@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 12:46:27 +0000
Message-Id: <1036327587.29642.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 02:43, Werner Almesberger wrote:
> > What you are suggesting is the equivalent of marking documents 'secret'
> > by putting them in a specific drawer and hoping nobody ever misfiles it.
> > Everyone instead writes "secret" on the document - guess why
> 
> This happens if you have a design that is based on taking away
> privileges/rights/capabilities/power/whatever. If the "naked"
> object has no special powers, misfiling it does no damage at all.

That isnt actually true. When you misfile it you mistakenly give it
powers. An untrusted document stuck in the secret drawer becomes seen to
have much higher value. It might for example lead the military to
believe a project is secret, make a decision on that basis and get
everyone shot because the opponents knew about it.

Alan

