Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262132AbSIYWtI>; Wed, 25 Sep 2002 18:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262133AbSIYWtH>; Wed, 25 Sep 2002 18:49:07 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:25322 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S262132AbSIYWtH>;
	Wed, 25 Sep 2002 18:49:07 -0400
Date: Thu, 26 Sep 2002 00:54:15 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Message-ID: <20020925225415.GB4768@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0209242223040.22735-100000@imladris.surriel.com> <EFED8A1D-D02F-11D6-AD2E-000502C90EA3@Whitewlf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EFED8A1D-D02F-11D6-AD2E-000502C90EA3@Whitewlf.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 September 2002, at 22:38:56 -0400,
Adam Goldstein wrote:

> Can anyone recommend any long term cumulative monitors for vmstat,  
> and/or other processes that could run behind the scenes and gather  
> cooperative data? Personally, I can't make heads or tails of the vmstat  
> output, and, I still have as of yet to get a -real- answer for what   
> "load" is.. besides the knee-jerk answer of "its the avg load over X  
> minutes".  :)
> 
apt-cache show sysstat
...
Description: sar, iostat and mpstat - system performance tools for Linux

The above are very well known performance monitoring tools used in the
UNIX world, that can gather periodic measures of many of your system's 
usage parameters. Check the man pages for details :-)

Hope this helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
