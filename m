Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288878AbSANS5F>; Mon, 14 Jan 2002 13:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288828AbSANSyW>; Mon, 14 Jan 2002 13:54:22 -0500
Received: from bitmover.com ([192.132.92.2]:20353 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S288834AbSANSxn>;
	Mon, 14 Jan 2002 13:53:43 -0500
Date: Mon, 14 Jan 2002 10:53:41 -0800
From: Larry McVoy <lm@bitmover.com>
To: Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@thyrsus.com>,
        Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114105341.E27433@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Dave Jones <davej@suse.de>, "Eric S. Raymond" <esr@thyrsus.com>,
	Eli Carter <eli.carter@inet.com>,
	"Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <F50839283B51D211BC300008C7A4D63F0C10759D@eukgunt002.uk.eu.ericsson.se> <20020114111141.A14332@thyrsus.com> <3C430E89.E65DCEDC@inet.com> <20020114125228.B14747@thyrsus.com> <20020114193823.H15139@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114193823.H15139@suse.de>; from davej@suse.de on Mon, Jan 14, 2002 at 07:38:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 07:38:24PM +0100, Dave Jones wrote:
> On Mon, Jan 14, 2002 at 12:52:28PM -0500, Eric S. Raymond wrote:
>  > She complains of occasional lockups, and that she gets skips when
>  > playing her Guy Lombardo MP3s.  Melvin says, over the phone: "Yup,
>  > that version had some VM problems.  And you need the low-latency stuff
>  > that went in three releases ago.
> 
>  ... and the 200 patches that the vendor added that she's become
>  so used to just being there...

Yeah, what Dave said.  Eric, your approach is pushing Aunt Tillie towards
more variations and what the Aunt Tillie needs is less.   Ditto for the
distro vendors.  They want as few as possible different kernels running
out there, the more variations there the greater the support load.  It's
the *opposite* of what the Linux kernel community wants, they want the 
broadest coverage of combinations they can get, that shows up more bugs.
If a distro vendor could get away with exactly one kernel config, they
would.  Even if it made for a 20MB kernel image, the support tradeoff 
is a win.

Supporting products for Aunt Tillie is very different than supporting
products for a bunch of hackers.  One wants "it works" and the other
wants "the source".
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
