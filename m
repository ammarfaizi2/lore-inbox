Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287150AbRL2HmC>; Sat, 29 Dec 2001 02:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287151AbRL2Hlw>; Sat, 29 Dec 2001 02:41:52 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53186 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S287150AbRL2Hlo>;
	Sat, 29 Dec 2001 02:41:44 -0500
Date: Sat, 29 Dec 2001 02:41:43 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system
Message-ID: <20011229024143.A11696@havoc.gtf.org>
In-Reply-To: <20011229042139.GC14067@thune.mrc-home.com> <9467.1009601050@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9467.1009601050@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Dec 29, 2001 at 03:44:10PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2001 at 03:44:10PM +1100, Keith Owens wrote:
> What Mr. Fishtank seems to overlook is that kbuild 2.5 is far more
> flexible and accurate than 2.4, including features that lots of people
> want, like separate source and object trees.

I don't see the masses, or, well, anybody on lkml, clamoring for this.

IIRC from the kernel summit SGI was the only entity clamoring for this.


> Now that the overall
> kbuild design is correct, the core code can be rewritten for speed.
> And that will be done a couple of weeks after kbuild 2.5 goes into the
> kernel, then I expect kbuild 2.5 to be faster than kbuild 2.4 even on
> full builds.

Ok... you want kbuild into 2.5 ASAP, only to submit a rewrite two weeks later?

If so it makes even less sense to get kbuild into 2.5.x now.

	Jeff


