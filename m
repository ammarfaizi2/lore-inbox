Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVHLKks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVHLKks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 06:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbVHLKks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 06:40:48 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:55304 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S932167AbVHLKkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 06:40:47 -0400
Date: Fri, 12 Aug 2005 11:40:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] remove support for gcc < 3.2
In-Reply-To: <Pine.LNX.4.62.0508120938560.18366@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.61L.0508121136110.1472@blysk.ds.pg.gda.pl>
References: <20050731222606.GL3608@stusta.de> <21d7e99705080318347d6b58d5@mail.gmail.com>
 <20050804065447.GB25606@lug-owl.de> <Pine.LNX.4.62.0508120938560.18366@numbat.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005, Geert Uytterhoeven wrote:

> > -sh-3.00# cat cpuinfo
> > cpu             : VAX
> > cpu type        : KA43
> > cpu sid         : 0x0b000006
> > cpu sidex       : 0x04010002
> > page size       : 4096
> > BogoMIPS        : 10.08
> > -sh-3.00# cat version
> > Linux version 2.6.12 (jbglaw@d2) (gcc version 4.1.0 20050803 (experimental)) #2 Wed Aug 3 23:42:11 CEST 2005
> 
> Any change we will see this code in mainline?
> Or do you wait for a 25th anniversary of your hardware, or something like that?
> ;-)

 I guess the 25th anniversary has already happened -- there was even a 
nice history of DEC computing published at that time as it coincided with 
the 50th anniversary of the company itself.  That's for VAX in general, 
rather than a specific implementation, though.

 Anyway I second the question, although I have a bit more interest in this 
area these days and I may push the merge myslef if nobody else bothers. 
;-)

  Maciej
