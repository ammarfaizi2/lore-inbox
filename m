Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287731AbSANRAc>; Mon, 14 Jan 2002 12:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287720AbSANRAM>; Mon, 14 Jan 2002 12:00:12 -0500
Received: from zeke.inet.com ([199.171.211.198]:16782 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S287734AbSANRAH>;
	Mon, 14 Jan 2002 12:00:07 -0500
Message-ID: <3C430E89.E65DCEDC@inet.com>
Date: Mon, 14 Jan 2002 10:59:53 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-10enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <F50839283B51D211BC300008C7A4D63F0C10759D@eukgunt002.uk.eu.ericsson.se> <20020114111141.A14332@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Michael Lazarou (ETL) <Michael.Lazarou@etl.ericsson.se>:
> > Doesn't this mean that you would need a fully functional kernel
> > before you get to run the autoconfigurator?
> 
> Yes, but this was always true.

And if the reason you are building a new kernel is that the old one is
mis-identifying some of your hardware? ;)

Could you maybe describe the problem you are trying to solve a bit more
clearly than "the hardware-discovery problem for ISA devices"?  If you
are trying to discover the ISA devices, but rely upon them having
already been discovered, what are you accomplishing?

Puzzled,

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
