Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283758AbRK3SnV>; Fri, 30 Nov 2001 13:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283760AbRK3SnM>; Fri, 30 Nov 2001 13:43:12 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:6072 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S283758AbRK3SnC>; Fri, 30 Nov 2001 13:43:02 -0500
Date: Fri, 30 Nov 2001 19:40:29 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: dalecki@evision.ag
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <3C07C82D.A70BA43@evision-ventures.com>
Message-ID: <Pine.GSO.3.96.1011130193741.23286D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2001, Martin Dalecki wrote:

> > Please explain.  Especially contentrate on justifing why serial interfaces
> > aren't a tty device.
> 
> No problem ;-).
> 
> There is the hardware: in esp. the serial controller itself - this
> belongs
> to misc, becouse a mouse for example doesn't have to interpret any tty
> stuff

 The same applies to the console keyboard, which is hooked to a standard
UART on certain systems as well. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

