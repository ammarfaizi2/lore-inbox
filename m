Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288954AbSA3IG4>; Wed, 30 Jan 2002 03:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288944AbSA3IE6>; Wed, 30 Jan 2002 03:04:58 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:36238 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288828AbSA3IEj>;
	Wed, 30 Jan 2002 03:04:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Subject: Re: unresolved symbols __udivdi3 and __umoddi3
Date: Wed, 30 Jan 2002 09:09:32 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200201291638.g0TGcohv001323@tigger.cs.uni-dortmund.de>
In-Reply-To: <200201291638.g0TGcohv001323@tigger.cs.uni-dortmund.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VpoC-0000Cu-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 05:38 pm, Horst von Brand wrote:
> Daniel Phillips <phillips@bonn-fries.net> said:
> 
> [...]
> 
> > Do you know where to find documentation for the assembly instructions 
> > themselves?
> 
> Standard ia32 references, i.e., at Intel's website. Beware, it is some 500
> pages PDF. But they (and standard PC assembly books) use the nearly
> unreadable Intel syntax with operands the other way around, so this is much
> less of a help than it could be.

I was afraid somebody would say that.

I need look no further than the shelf at my right hand for a full set of 
Pentium documentation.  I do not consider that an adequate substitute for a 
document expressing the syntax of all machine instructions of a particular 
architecture in the GNU syntax.

The only excuse I can think of for not having such a document is "we're all 
so busy we couldn't write it, please use the Intel documentation".  Please 
don't suggest that we have no need for our own documentmentation, written in 
a form familiar to us.

> Has anyone gotten a instruction listing (just instructions and short
> description, not the whole other stuff in there), preferably in AT&T
> syntax?

Err, now I feel I wrote the above a little too strongly, but I'm not going to 
change it, because it was my initial reaction.  Yes, that's *exactly* what I 
want.

-- 
Daniel
