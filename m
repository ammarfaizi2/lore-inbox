Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265280AbSJaSZx>; Thu, 31 Oct 2002 13:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265272AbSJaSYv>; Thu, 31 Oct 2002 13:24:51 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:33414 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265270AbSJaSYn>; Thu, 31 Oct 2002 13:24:43 -0500
Subject: Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <3DC171FF.5000803@nortelnetworks.com>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
	 <3DC171FF.5000803@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Oct 2002 18:50:36 +0000
Message-Id: <1036090236.8575.90.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 18:10, Chris Friesen wrote:
> > To me this says "LKCD is stupid". Which means that I'm not going to apply 
> > it, and I'm going to need some real reason to do so - ie being proven 
> > wrong in the field.
> 
> How do you deal with netdump when your network driver is what caused the 
> crash?

Netdump drives the system itself. Any dump driver has to as it cant
assume the system is in a remotely sane state


