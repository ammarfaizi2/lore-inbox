Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLFGhn>; Wed, 6 Dec 2000 01:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbQLFGhe>; Wed, 6 Dec 2000 01:37:34 -0500
Received: from out2.prserv.net ([32.97.166.32]:38843 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S129524AbQLFGhV>;
	Wed, 6 Dec 2000 01:37:21 -0500
Date: Tue, 5 Dec 2000 22:06:23 -0800
From: Darrell A Escola <descola@attglobal.net>
To: Taco IJsselmuiden <taco@wep.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NE2000 (ISA) not loading on test11
Message-ID: <20001205220623.A23928@attglobal.net>
Reply-To: descola@attglobal.net
Mail-Followup-To: Darrell A Escola <descola@attglobal.net>,
	Taco IJsselmuiden <taco@wep.tudelft.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012060257090.19232-100000@hewpac.taco.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012060257090.19232-100000@hewpac.taco.dhs.org>; from taco@wep.tudelft.nl on Wed, Dec 06, 2000 at 03:05:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2000 at 03:05:59AM +0100, Taco IJsselmuiden wrote:
> Hi,
> 
> I just found out that I can't load the ne2000 (ne.o) module under test11.
> test10 works fine ... Did I miss some big change between test10 and test11
> or are the params io / irq just working different right now ??
> 
> Greetz,
> Taco.
> 

...

Stock 2.4.0-test11 ne.o working fine here using Linksys ISA Ether16 LAN Card.

Darrell
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
