Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132990AbRBEPaz>; Mon, 5 Feb 2001 10:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133053AbRBEPap>; Mon, 5 Feb 2001 10:30:45 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:46900 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S132990AbRBEPam>;
	Mon, 5 Feb 2001 10:30:42 -0500
Message-ID: <20010205163024.A19399@win.tue.nl>
Date: Mon, 5 Feb 2001 16:30:24 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, rbrito@iname.com
Subject: Re: Slowing down CDROM drives (was: Re: ATAPI CDRW which doesn't work)
In-Reply-To: <20010203230544.A549@MourOnLine.dnsalias.org> <20010205020952.B1276@suse.de> <20010205013424.A15384@iname.com> <20010205144043.H849@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010205144043.H849@nightmaster.csn.tu-chemnitz.de>; from Ingo Oeser on Mon, Feb 05, 2001 at 02:40:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Feb 05, 2001 at 01:34:24AM -0200, Rogerio Brito wrote:
> > 	Well, this has nothing to do with the above, but is there any
> > 	utility or /proc entry that lets me say to my CD drive that it
> > 	should not work at full speed?

I missed the original post, but there is a mount flag "-o speed="
for precisely this purpose.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
