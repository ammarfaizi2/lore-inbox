Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSKESKE>; Tue, 5 Nov 2002 13:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264949AbSKESJ3>; Tue, 5 Nov 2002 13:09:29 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42389 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265097AbSKESIL>; Tue, 5 Nov 2002 13:08:11 -0500
Subject: Re: [lkcd-devel] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Werner Almesberger <wa@almesberger.net>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <20021105150048.H1408@almesberger.net>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
	<3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net>
	<20021105171230.A11443@in.ibm.com>  <20021105150048.H1408@almesberger.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 18:36:00 +0000
Message-Id: <1036521360.5012.116.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 18:00, Werner Almesberger wrote:
> Yes, I've just checked with Eric, and he hasn't received any
> indication from Linus so far. I posted a reminder to linux-kernel.
> I'd really hate to see kexec miss 2.6.

Let me ask the same dumb question - what does kexec need that a dumper
doesn't. In other words given reboot/trap hooks can kexec happily live
as a standalone module ?

