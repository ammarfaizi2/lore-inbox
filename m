Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTDIDi4 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 23:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTDIDi4 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 23:38:56 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:59610 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S262695AbTDIDiz (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 23:38:55 -0400
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: "Matt D. Robinson" <yakker@alacritech.com>
Subject: Re: Linux kernel crash dumps (LKCD) and PowerPC ports.
Date: Tue, 8 Apr 2003 23:49:27 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200304081647.32146.ADharankar@ATTBI.Com> <1049843693.10620.34.camel@lambda.alacritech.com>
In-Reply-To: <1049843693.10620.34.camel@lambda.alacritech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304082349.27844.ADharankar@ATTBI.Com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt, thanks for the pointers!

Looking at those sites, it appears that the development at
"http://lists.insecure.org/lists/linux-kernel/2003/Feb/0987.html."
which I had pointed is based on the SGI's dump scheme. Same
for the one you pointed to.

The other scheme I poinited to (from Mission Critical Linux/MCLX)
seems to have some strong points too. Any pointers to discussions
about why the LKCD work seems to more active than the
MCLX one?

Best regards,
-Arun.


On Tuesday 08 April 2003 07:14 pm, Matt D. Robinson wrote:
> Please look at the lkcd-devel mailing archives.  There is
> at least one group working on a PPC port of LKCD
>
> 	http://sourceforge.net/mail/?group_id=2726
>
> --Matt
>
> On Tue, 2003-04-08 at 13:47, Arun Dharankar wrote:
> > Greetings.
> >
> > >From what I able to find from some searching around, the implementation
> >
> > by MCLX ("http://oss.missioncriticallinux.com/projects/mcore/") is being
> > carried on at
> > http://lists.insecure.org/lists/linux-kernel/2003/Feb/0987.html.
> >
> > Looking at these patches, I can only see x86 architecture support for
> > in memory kernel crash dump support. Is anyone actively working on the
> > PowerPC architecture?
> >
> > Best regards,
> > -Arun.
