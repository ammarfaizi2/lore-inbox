Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288956AbSA3InX>; Wed, 30 Jan 2002 03:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288984AbSA3InO>; Wed, 30 Jan 2002 03:43:14 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52942 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S288956AbSA3InE>;
	Wed, 30 Jan 2002 03:43:04 -0500
Date: Wed, 30 Jan 2002 03:43:02 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Message-ID: <20020130034302.J32317@havoc.gtf.org>
In-Reply-To: <200201291638.g0TGcohv001323@tigger.cs.uni-dortmund.de> <E16VpoC-0000Cu-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16VpoC-0000Cu-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Jan 30, 2002 at 09:09:32AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:09:32AM +0100, Daniel Phillips wrote:
> I need look no further than the shelf at my right hand for a full set of 
> Pentium documentation.  I do not consider that an adequate substitute for a 
> document expressing the syntax of all machine instructions of a particular 
> architecture in the GNU syntax.
[...]
> > Has anyone gotten a instruction listing (just instructions and short
> > description, not the whole other stuff in there), preferably in AT&T
> > syntax?
> 
> Err, now I feel I wrote the above a little too strongly, but I'm not going to 
> change it, because it was my initial reaction.  Yes, that's *exactly* what I 
> want.

Then whip up a Perl script or somesuch, and generate that from the data
provided in binutils.

	Jeff


