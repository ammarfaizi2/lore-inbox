Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTH0GBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263123AbTH0GBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:01:33 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263122AbTH0GBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:01:31 -0400
Date: Wed, 27 Aug 2003 07:10:45 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308270610.h7R6Ajwt000277@81-2-122-30.bradfords.org.uk>
To: john@grabjohn.com, retes_simbad@yahoo.es
Subject: Re: linux-2.4.22 released
Cc: aradorlinux@yahoo.es, bunk@fs.tum.de, jamagallon@able.es,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From retes_simbad@yahoo.es  Wed Aug 27 06:57:15 2003
> Envelope-To: john@bradfords.org.uk
> Subject: Re: linux-2.4.22 released
> From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?= =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
> To: John Bradford <john@grabjohn.com>
> Cc: aradorlinux@yahoo.es, bunk@fs.tum.de, jamagallon@able.es,
>    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> In-Reply-To: <200308262225.h7QMPe0J000367@81-2-122-30.bradfords.org.uk>
> References: <200308262225.h7QMPe0J000367@81-2-122-30.bradfords.org.uk>
> Content-Type: text/plain; charset=iso-8859-15
> Mime-Version: 1.0
> X-Mailer: Ximian Evolution 1.4.4 
> Date: Wed, 27 Aug 2003 04:11:47 +0200
> X-MIME-Autoconverted: from 8bit to quoted-printable by newton.xela.co.uk id h7R2Brq02217
> Content-Transfer-Encoding: 8bit
> X-MIME-Autoconverted: from quoted-printable to 8bit by 81-2-122-30.bradfords.org.uk id h7R5uwqS000105
>
> El mié, 27-08-2003 a las 00:25, John Bradford escribió:
>
> > I think the 'more urgent things to be fixed' point is important.
>
> Well, Linux is used in many circunstances, for desktop, for
> workstations, for servers, every user have a specific "urgent thing" 

Yes, of course, but the majority of desktop, workstations and server
machines run whatever kernel their distribution supplies.

Within a year, a lot of distributions will start offering both 2.4 and
2.6.  The only reason to run the distribution's 2.4 kernel will be if
the 2.6 one doesn't work on the user's hardware.  In that case, we
will want to add support to/fix 2.6 as a priority, rather than adding
support to 2.4.

Only users with specific requirements will replace a distribution's
2.6 kernel with their own compiled 2.4 kernel, and those users will
typically be knowledgeable enough to use different trees, pre-patches,
out of tree drivers, or whatever is necessary to add the features,
(such as ALSA), to 2.4.

> > Only a certain amount of patches can go in to 2.4.23 if we want to
> > keep this a short development cycle, and efforts to stabilise 2.4 so
> > that embedded users who are still using 2.2 have something to migrate
> > to are important.
>
> why shorts development cycles? Stable development cycles must be long
> cycles for test every change...

Maybe longer than the 2.4.22 development cycle, but I think almost
everybody agrees that too much was done between 2.4.20 and 2.4.21.

> If embedded users are still using 2.2,
> stabilising 2.4 is important as much as keeping up to date the drivers
> for desktop users and support new hardware I think...

I think new development should concentrate on 2.6, otherwise it's just
going to be delayed longer than necessary.

John.
