Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTLBOHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 09:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTLBOHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 09:07:32 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:20229 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262104AbTLBOHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 09:07:31 -0500
Date: Tue, 2 Dec 2003 12:12:19 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Ionut Georgescu <george@physik.tu-cottbus.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031202141219.GE13388@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Ed Sweetman <ed.sweetman@wmich.edu>,
	Ionut Georgescu <george@physik.tu-cottbus.de>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br> <20031202131311.GA10915@physik.tu-cottbus.de> <3FCC95BB.60205@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCC95BB.60205@wmich.edu>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 02, 2003 at 08:38:03AM -0500, Ed Sweetman escreveu:
> Ionut Georgescu wrote:
> >Because new hardware requires newest kernel, and neither I, nor the
> >majority of the users out there have the knowledge to 'forward' apply
> >patches.
> >
> >Even if 2.4 is phasing out, the process has just begun and it will last
> >a lot until 2.6 will be ready for production systems.
> >
> >We are not talking about a fancy, experimental feature. We are talking
> >about a mature, serious project, that has been traveling for 3 years
> >along the 2.4 kernel and with even more years of testing and research
> >behind. I find it just pitty for the linux kernel not to include it.
> >
> >When going to a conference, you don't present the brand new stuff you
> >have just computed or measured the night before, because you just can't
> >know if it is correct or not. Instead, you will present older, but
> >mature work, that you can swear on. The same with the 2.6 kernel.
> >Everybody is pushing it in front, but no one is using it for production
> >systems. XFS and 2.4 are, even together, old, mature work, that anybody
> >would 'present' anywhere.
> >
> >Regards,
> >Ionut
> 
> 
> The point was, the patch is perfectly and easily usable the way it is. 
> There stands to be no reason to make it part of the vanilla kernel other 
> than a very slight convenience factor for a small minority of users. 
> Tosatti thinks that that versus changes to this stable kernel that touch 
> common code are unacceptable.  Despite the maturity of the project, it 
> just doesn't make sense to include it in the vanilla kernel, it would be 
> a disservice to the rest of the users of 2.4.x kernels that do so for 
> stability, not only in the not crashing sense, but also in the code-base 
>  sense. And the number of users who don't use xfs so greatly outnumber 
> the users that do that it's a mute point for Tosatti.

<humour>
Thanks for reading my mind and writing it down 8)
</humour>

- Arnaldo
