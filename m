Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289053AbSA3KPR>; Wed, 30 Jan 2002 05:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289051AbSA3KPH>; Wed, 30 Jan 2002 05:15:07 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:47109 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289055AbSA3KOu>; Wed, 30 Jan 2002 05:14:50 -0500
Date: Wed, 30 Jan 2002 10:14:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130101441.B16937@flint.arm.linux.org.uk>
In-Reply-To: <rmk@arm.linux.org.uk> <200201300944.g0U9iOeO002104@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201300944.g0U9iOeO002104@tigger.cs.uni-dortmund.de>; from brand@jupiter.cs.uni-dortmund.de on Wed, Jan 30, 2002 at 10:44:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 10:44:24AM +0100, Horst von Brand wrote:
> Russell King <rmk@arm.linux.org.uk> said:
> > If we're going to be doing this periodically, it might be an idea to
> > put "out of order since dd mmm yyyy" and a "last checked dd mmm yyyy"
> > at the top of the file.
> 
> Perhaps add a "Last checked: field to each (too)?

Old ground - see Message-ID: <20020129144307.B6542@flint.arm.linux.org.uk>

> But then again, patches to MAINTAINERS are silently dropped. Perhaps this
> should be posted on kernel.org?

I suspect that's because Linus gets patches to it from people he's never
heard of before (ie, the new people taking over), but without seeing
anything that says that the old maintainer has gone.

I think this is something that someone could pick up this, and be the
contact point for both maintainers leaving, and new maintainers
taking over - if you like the MAINTAINERS maintainer.  Obviously this
should be someone Linus trusts.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

