Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbTDAKOb>; Tue, 1 Apr 2003 05:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262243AbTDAKOb>; Tue, 1 Apr 2003 05:14:31 -0500
Received: from vhe-530008.sshn.net ([195.169.222.38]:13441 "EHLO
	elektron.atoom.net") by vger.kernel.org with ESMTP
	id <S262238AbTDAKO3>; Tue, 1 Apr 2003 05:14:29 -0500
Date: Tue, 1 Apr 2003 12:25:49 +0200
From: Miek Gieben <miekg@atoom.net>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre6 and usb-uhci
Message-ID: <20030401102549.GB13787@atoom.net>
References: <20030401093646.GA11420@atoom.net> <20030401120408.3eefea6f.martin.zwickel@technotrend.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401120408.3eefea6f.martin.zwickel@technotrend.de>
User-Agent: Vim/Mutt/Linux
X-Home: www.miek.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[On 01 Apr, @12:04, Martin wrote in "Re: 2.4.21-pre6 and usb-uhci ..."]
> 
> try using it as a module!
> 
> from greg:
> > Yes, the usb host controller drivers do not get built in 2.4.21-pre6
> > if
> > selected to be compiled into the kernel.  This was my fault, and a
> > patch
> > has been sent to Marcelo to fix this.
> > 
> > Sorry,
> > 
> > greg k-h

thanks, didn't see this message when looking for a solution...

grtz Miek
