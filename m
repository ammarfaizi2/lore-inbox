Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTBDLZr>; Tue, 4 Feb 2003 06:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTBDLZr>; Tue, 4 Feb 2003 06:25:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20883
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267235AbTBDLZq>; Tue, 4 Feb 2003 06:25:46 -0500
Subject: Re: RFC: a code slush for 2.5?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerhard Mack <gmack@innerfire.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0302031316040.4263-100000@innerfire.net>
References: <Pine.LNX.4.44.0302031316040.4263-100000@innerfire.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044361923.23312.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Feb 2003 12:32:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 18:18, Gerhard Mack wrote:
> > So, if I had to make the proposal concrete, I would propose:
> > 	"code slush" effective immediately
> > 	code freeze, Easter holiday (April 19?)
> >
> > Comments/curses?
> 
> It would be wise if a freeze was delayed until after at least IDE and
> console switching both work reliably with preempt enabled.

In which case April is unrealistic. Actually given the huge backlog
from Linus holiday its pointless to even try and guess at things right
now. We need to see what it looks like by about 2.5.63 to judge


Alan

