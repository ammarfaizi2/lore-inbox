Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTLBNNy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 08:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTLBNNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 08:13:54 -0500
Received: from strauss.physik.TU-Cottbus.De ([141.43.75.28]:36295 "EHLO
	strauss.physik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S262051AbTLBNNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 08:13:52 -0500
Date: Tue, 2 Dec 2003 14:13:11 +0100
From: Ionut Georgescu <george@physik.tu-cottbus.de>
To: linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: Linux 2.4 future
Message-ID: <20031202131311.GA10915@physik.tu-cottbus.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202120315.GK13388@conectiva.com.br>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because new hardware requires newest kernel, and neither I, nor the
majority of the users out there have the knowledge to 'forward' apply
patches.

Even if 2.4 is phasing out, the process has just begun and it will last
a lot until 2.6 will be ready for production systems.

We are not talking about a fancy, experimental feature. We are talking
about a mature, serious project, that has been traveling for 3 years
along the 2.4 kernel and with even more years of testing and research
behind. I find it just pitty for the linux kernel not to include it.

When going to a conference, you don't present the brand new stuff you
have just computed or measured the night before, because you just can't
know if it is correct or not. Instead, you will present older, but
mature work, that you can swear on. The same with the 2.6 kernel.
Everybody is pushing it in front, but no one is using it for production
systems. XFS and 2.4 are, even together, old, mature work, that anybody
would 'present' anywhere.

Regards,
Ionut


On Tue, Dec 02, 2003 at 10:03:15AM -0200, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 02, 2003 at 12:54:36PM +0100, Ionut Georgescu escreveu:
> > I can only second that. We've been using XFS here since the days of
> > 2.4.0-testxx and the only problems we've had were sitting between the
> > chair and the keyboard.
> 
> So if there is no problems at all using it as a patch why add this to a
> kernel that is phasing out?
> 
> - Arnaldo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
***************
* Ionut Georgescu
* http://www.physik.tu-cottbus.de/~george/
* Registered Linux User #244479
*
* "In Windows you can do everything Microsoft wants you to do; in Unix you
*                can do anything the computer is able to do."

