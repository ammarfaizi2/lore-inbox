Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268231AbTALFEP>; Sun, 12 Jan 2003 00:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268234AbTALFEP>; Sun, 12 Jan 2003 00:04:15 -0500
Received: from fluent2.pyramid.net ([206.100.220.213]:13705 "EHLO
	fluent2.pyramid.net") by vger.kernel.org with ESMTP
	id <S268231AbTALFEO>; Sun, 12 Jan 2003 00:04:14 -0500
Message-Id: <5.2.0.9.0.20030111210824.01d30bc0@fluent2.pyramid.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Sat, 11 Jan 2003 21:12:58 -0800
To: robw@optonline.net, David Lang <dlang@diginsite.com>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: The GPL, the kernel, and everything else.
Cc: Ryan Anderson <ryan@michonline.com>,
       Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1042347339.1033.191.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301112006430.30519-100000@dlang.diginsite.com>
 <Pine.LNX.4.44.0301112006430.30519-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:55 PM 1/11/03 -0500, Rob Wilkens wrote:
> > as for signing kernel modules as being 'good' you have a serious problem
> > in the Linux world that there is no central authority to do any such
> > signing.
>
>Microsoft uses Verisign I believe, which is a company linux commands
>like "whois" already use to do nameserver lookups for example.  It's a
>third party, and hardware manufacturers probably already have
>certificates from them.

Microsoft doesn't use Verisign for its driver signing -- it's a proprietary 
system that is hard-wired into Windows.  I would guess you are confusing 
SSL certificates with module signatures.

As for "whois" you will find the default host for the GNU version is 
"whois.crsnic.net", which is not Verisign.

Microsoft signs modules that passes their test suite, and for which vendors 
pay a pretty penny (five digits' worth in US Dollars, if I recall 
correctly).  There is no comparable central authority for Linux or GNU 
software, nor would vendors be interested in spending the kind of dollars 
that would be associated with that sort of certification.  If they would, I 
would LOVE to start such a business.

Satch



-- 
The human mind treats a new idea the way the body treats a strange
protein:  it rejects it.  -- P. Medawar
This posting is for entertainment purposes only; it is not a legal opinion.

