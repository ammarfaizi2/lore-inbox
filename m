Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267823AbTAHRj2>; Wed, 8 Jan 2003 12:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267827AbTAHRj2>; Wed, 8 Jan 2003 12:39:28 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:21673 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S267823AbTAHRj1>; Wed, 8 Jan 2003 12:39:27 -0500
Message-Id: <4.3.2.7.2.20030108124514.02d6f1d0@pop.rcn.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 08 Jan 2003 12:53:57 -0500
To: apache-modules@covalent.net
From: Charles Reitzel <creitzel@rcn.com>
Subject: Re: [apache-modules] Best HTML Parser
Cc: apache-modules@covalent.net, DCOM <DCOM@DISCUSS.MICROSOFT.COM>,
       Linux Kernel <linux-kernel@vger.kernel.org>, modssl-users@modssl.org,
       netfilter@lists.netfilter.org, TEAMICE <teamice@yahoogroups.com>
In-Reply-To: <5.2.0.9.0.20030108124223.009f3e00@mail.SoftHome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am partial to HTML Tidy for a few reasons:

1) cross-platform, reentrant C library
2) very forgiving of sloppy, malformed markup
3) produces clean markup - XHTML if requested
4) C++, Perl, Pascal, COM and .NET bindings available,
    others easily done with SWIG

But I must admit, as one of the primary developers, I am probably 
biased.  But if you need to get your markup cleaned up so that you can 
apply XML tools to it, it is probably the best game in town.

For more info: http://tidy.sourceforge.net/

take it easy,
Charlie


At 12:43 PM 1/8/2003 +0530, Blesson Paul wrote:
>Hi all
>              Which is the Best HTML Parser in C/C++
>
>regards
>Blesson Paul

