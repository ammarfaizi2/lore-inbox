Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310433AbSCGSDt>; Thu, 7 Mar 2002 13:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310434AbSCGSDj>; Thu, 7 Mar 2002 13:03:39 -0500
Received: from dspnet.claranet.fr ([212.43.196.92]:34321 "HELO
	dspnet.fr.eu.org") by vger.kernel.org with SMTP id <S310433AbSCGSDV>;
	Thu, 7 Mar 2002 13:03:21 -0500
Date: Thu, 7 Mar 2002 19:02:34 +0100
From: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020307190234.T20273@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 04:51:56PM +0000, Henning P. Schmiedehausen wrote:
> Larry McVoy <lm@bitmover.com> writes:
> >	# extract all the patches from 2.5.0 onward.
> >	bk prs -hrv2.5.0.. |  while read x
> >	do	bk export -tpatch -r$i > ~ftp/patches/patch-$i
> >	done
> [henning@henning henning]$ bk prs -hrv2.5.0.. |  while read x
> while: Expression Syntax.
> You obviously just _underlined_ the point, Larry.
> ...
> It's tcsh; before you ask.

tss ..

by the way, shouldn't it be "$x" in the second line ?
or am I missing something ?

	JL
