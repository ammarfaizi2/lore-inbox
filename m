Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWCRQLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWCRQLi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 11:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWCRQLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 11:11:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56019 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750813AbWCRQLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 11:11:37 -0500
Subject: Re: Idea: Automatic binary driver compiling system
From: Arjan van de Ven <arjan@infradead.org>
To: Benjamin Bach <benjamin@overtag.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <441C2CF6.1050607@overtag.dk>
References: <441AF93C.6040407@overtag.dk>
	 <1142620509.25258.53.camel@mindpipe>  <441C213A.3000404@overtag.dk>
	 <1142694655.2889.22.camel@laptopd505.fenrus.org>
	 <441C2CF6.1050607@overtag.dk>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 17:11:32 +0100
Message-Id: <1142698292.2889.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 16:53 +0100, Benjamin Bach wrote:
> Arjan van de Ven wrote:
> > there are over a thousand open source drivers, and at most a handful
> > binary ones. Please go do your math.
> >   
> You're doing the wrong comparison. How many drivers are missing

not too many. This is largely because hardware interfaces are getting
increasingly standardized (it's cheaper for the hw vendors to not have
to create a new driver for Windows XP)

>  or
> lacking in ability?

some. But the vast majority is "good enough" by any standard.

>  And if you add to your handful of binary drivers
> those thousands that exist for xp...

then it's clear that linux is better off ;)
(and yes while XP has more drivers, in linux a driver would generally
drive the hardware that in the windows world uses 10 to 20  drivers)

> well, numbers do change. Also, most open source drivers aren't made by
> the vendors themselves.

and? For standard interfaces... no big deal.
And for non-standard interfaces.. it's increasingly done with the vendor
help

> 
> We're doing subjective math here. It doesn't change the fact that Linux
> would be better off with improved hardware support, right?

yes. But "more binary drivers" is absolutely not "better off"; but
that's going towards the usual bimonthly troll topic so lets not go
there and stop here.


