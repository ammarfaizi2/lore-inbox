Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265965AbSKBNYN>; Sat, 2 Nov 2002 08:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265968AbSKBNYN>; Sat, 2 Nov 2002 08:24:13 -0500
Received: from 12-222-92-50.client.insightBB.com ([12.222.92.50]:42393 "EHLO
	lucky") by vger.kernel.org with ESMTP id <S265965AbSKBNYM>;
	Sat, 2 Nov 2002 08:24:12 -0500
Date: Sat, 2 Nov 2002 08:30:34 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021102133034.GA26939@lucky>
Reply-To: shuey@purdue.edu
References: <Pine.LNX.4.44.0210302224180.20210-100000@nakedeye.aparity.com> <Pine.LNX.4.44.0210310737170.2035-100000@home.transmeta.com> <20021031171334.GA22597@snerble.cc.purdue.edu> <1036091071.8575.101.camel@irongate.swansea.linux.org.uk> <20021101222504.GA460@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101222504.GA460@elf.ucw.cz>
User-Agent: Mutt/1.4i
From: Michael Shuey <shuey@fmepnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 11:25:04PM +0100, Pavel Machek wrote:
> > Wouldn't you rather they neatly tftp'd dumps to a nominated central
> > server which noticed the arrival, did the initial processing with a perl
> > script and mailed you a summary ?
> 
> Out of interest, how does such "initial processing" look like?

Toss an email to root and the operations staff including the name of the
machine that crashed and the output of lcrash's "report" command, as well
as the location of the dumps (ie, where they were saved on the machine that
died and where they are on an optional netdump server).

-- 
Mike Shuey
