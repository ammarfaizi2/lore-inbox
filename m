Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289191AbSAVHjt>; Tue, 22 Jan 2002 02:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289190AbSAVHjm>; Tue, 22 Jan 2002 02:39:42 -0500
Received: from zero.tech9.net ([209.61.188.187]:17157 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289188AbSAVHja>;
	Tue, 22 Jan 2002 02:39:30 -0500
Subject: Re: 2.4.18pre4aa1
From: Robert Love <rml@tech9.net>
To: Dan Chen <crimsun@email.unc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020122073742.GA767@opeth.ath.cx>
In-Reply-To: <20020122074806.A1547@athlon.random>
	<1011682739.17096.563.camel@phantasy>  <20020122073742.GA767@opeth.ath.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 22 Jan 2002 02:43:58 -0500
Message-Id: <1011685438.17096.610.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 02:37, Dan Chen wrote:
> No weird anomalies here. I believe the ones you refer to were a result
> of ipv6 bits not being updated as well. Russell posted two patches for
> those.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101164602428323&w=2
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101164602428401&w=2

Maybe, although I seem to recall odd ICMP behavior being the problem. 
Although I don't think the above is in -aa.  Andrea, perhaps this too
should be merged?

Ideally this will all show up in 2.4-proper soon, anyhow.

	Robert Love

