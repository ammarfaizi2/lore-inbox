Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311316AbSCLTGi>; Tue, 12 Mar 2002 14:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311318AbSCLTG3>; Tue, 12 Mar 2002 14:06:29 -0500
Received: from h24-71-103-168.ss.shawcable.net ([24.71.103.168]:27923 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP
	id <S311316AbSCLTGP>; Tue, 12 Mar 2002 14:06:15 -0500
Date: Tue, 12 Mar 2002 13:06:47 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ns83820 0.17
Message-ID: <20020312130647.A5329@twoflower.internal.do>
In-Reply-To: <20020312004036.A3441@redhat.com> <51A3E836-35A8-11D6-A4A8-000393843900@metaparadigm.com> <20020312.031509.53067416.davem@redhat.com> <1015956757.4220.3.camel@aurora>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1015956757.4220.3.camel@aurora>; from tadams-lists@myrealbox.com on Tue, Mar 12, 2002 at 01:12:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trever L. Adams <tadams-lists@myrealbox.com> wrote:
> 
> Here is my question.  A PCI bus, IRC, has about 500 Megabytes/sec of
> bandwidth.

Depends.  32-bit 33Mhz PCI is 133MB/s.  64-bit 66MHz PCI is 533MB/s -- those
are theoretical, of course.  In real life you're not likely to see better than
about 90% of those figures, even in ideal cases.

> A full blown gigabit Ethernet stream should be around 133 Megabytes/sec.
> Sounds to me like a PC could act easily (As far as bandwidth is concerned)
> as a 4 to 5 port gigabit Ethernet router.

If you define PC as "cheap Athlon box with 32-bit, 33MHz PCI bus", then no.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
-----------------------------------------------------------------------
