Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTICWpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbTICWpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:45:09 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:27189 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S264320AbTICWo7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:44:59 -0400
Subject: Re: [ACPI] Where do I send APIC victims?
From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb@netcabo.pt>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Roger Luethi <rl@hellgate.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>,
       "Brown, Len" <len.brown@intel.com>
In-Reply-To: <Pine.LNX.4.44.0309031511420.6102-100000@logos.cnet>
References: <Pine.LNX.4.44.0309031511420.6102-100000@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 03 Sep 2003 23:44:43 +0100
Message-Id: <1062629083.1608.24.camel@darkstar.portugal>
Mime-Version: 1.0
X-OriginalArrivalTime: 03 Sep 2003 22:42:31.0861 (UTC) FILETIME=[A9480650:01C3726C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I am one APIC victim since Jan 2002. almost 2 years.
I suggested build one database of "APIC victims" 
"Hi I would like make a database of the computers that have to Turning
off APIC.  Model, mother board and chip set, processor type ,  and DSDT
signature.
And put in blacklist.c to give this exactly warning."

But what I would like to say here is: I try to understand where kernel
hangs when I enable APIC and doesn't hangs when IRQ routing is setting,
but hangs before, exactly when try to:
"evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode
successful." this message never appears.

PS: I just don't had begging  the database because, now,  I don't have
any time for that. But I had some ideas, like using  php to upload dsdt
bin and try automatically Disassemble AML to ASL using iasl as cgi etc. 

thanks

On Wed, 2003-09-03 at 19:13, Marcelo Tosatti wrote:
> 
> 
> On Wed, 3 Sep 2003, Alan Cox wrote:
> 
> > On Mer, 2003-09-03 at 11:48, Andrew de Quincey wrote:
> > > 2.4.22 has the ACPI from 2.6 backported into it, (which includes my patch for 
> > > nforce2 boards) so it will start having the same issue with the BIOS bug in 
> > > KT333/KT400  boards.
> > 
> > It does - 2.4.22pre7 is great on my boxes, 2.4.22 final ACPI is
> > basically unusable on anything I own thats not intel. 
> 
> I've collected a few 2.4.22 ACPI problems and sent them to the ACPI guys.
> 
> Randy, Len? Any update on any bug? 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
-- 
SérgioMB
email: sergiomb@netcabo.pt

Who gives me one shell, give me everything.

