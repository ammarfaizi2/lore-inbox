Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S161168AbQHIB3M>; Tue, 8 Aug 2000 21:29:12 -0400
Received: by vger.rutgers.edu id <S160317AbQHIB2t>; Tue, 8 Aug 2000 21:28:49 -0400
Received: from dnai-216-15-53-162.cust.dnai.com ([216.15.53.162]:64093 "EHLO exchange.ensim.com") by vger.rutgers.edu with ESMTP id <S161141AbQHIB0u>; Tue, 8 Aug 2000 21:26:50 -0400
From: Borislav Deianov <borislav@ensim.com>
Date: Tue, 8 Aug 2000 18:51:40 -0700
To: jmcneil@interland.com
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Lottery Scheduling?
Message-ID: <20000808185140.A32214@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: owner-linux-kernel@vger.rutgers.edu

Hi Jeff,

In article <A49466227BF7D311BB6900508B92D72AFD2221@MSX1> you wrote:
> Has there been any effort to impliment a lottery scheduler (or something of
> the sort) under Linux?  I've searched on the web but wasn't able to find
> anything.  I've been working on my own, but don't see any reason to reinvent
> the wheel here, I'm sure it's been done before, probably better than I could
> do.

Have a look at http://fairsched.sourceforge.net. This is a fair
scheduler, it allows you to do hierarchical weighted CPU allocation.
Rik van Riel also wrote one, perhaps closer to what you describe, get
it from http://www.surriel.com/patches/ .

Regards,
Borislav

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
