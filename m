Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQJaWtW>; Tue, 31 Oct 2000 17:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129673AbQJaWtM>; Tue, 31 Oct 2000 17:49:12 -0500
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:4698
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S129097AbQJaWtI>; Tue, 31 Oct 2000 17:49:08 -0500
Date: Tue, 31 Oct 2000 14:49:07 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001031144907.B23516@work.bitmover.com>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@timpanogas.org>,
	Larry McVoy <lm@bitmover.com>, Paul Menage <pmenage@ensim.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com> <39FF3D53.C46EB1A8@timpanogas.org> <20001031140534.A22819@work.bitmover.com> <39FF4488.83B6C1CE@timpanogas.org> <20001031142733.A23516@work.bitmover.com> <39FF49C8.475C2EA7@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <39FF49C8.475C2EA7@timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 03:38:00PM -0700, Jeff V. Merkey wrote:
> Larry McVoy wrote:
> > On Tue, Oct 31, 2000 at 03:15:37PM -0700, Jeff V. Merkey wrote:
> > > The quality of the networking code in Linux is quite excellent.  There's
> > > some scaling problems relative to NetWare.  We are firmly committed to
> > > getting something out with a Linux code base and NetWare metrics.  Love
> > > to have your help.
> > 
> > Jeff, I'm a little concerned with some of your statements.  Netware may
> > be the greatest thing since sliced bread, but it isn't a full operating
> > system, so comparing it to Linux is sort of meaningless.
> 
> It's makes more money in a week than Linux has ever made.  

And the relevance of that to this conversation is exactly what?

> A context switch in anoperating system context in it's simplest for is
> 
> mov    x, esp
> mov    esp, y
> 
> > and you can support all that and get user to user context switches in a
					 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Apology accepted.

No apology was extended.  You're spouting nonsense.  User to user means
process A in VM 1 switching to process B in VM 2.  I'm sorry, Mr Merkey,
but a 

	mov    x, esp
	mov    esp, y

doesn't begin to approach a user to user context switch.  Please go learn
what a user to user context switch is.  Then come back when you can do
one of those in a few cycles.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
