Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281985AbRK1HIv>; Wed, 28 Nov 2001 02:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281815AbRK1HIc>; Wed, 28 Nov 2001 02:08:32 -0500
Received: from aaf16.warszawa.sdi.tpnet.pl ([217.97.85.16]:6149 "EHLO
	aaf16.warszawa.sdi.tpnet.pl") by vger.kernel.org with ESMTP
	id <S281823AbRK1HIN>; Wed, 28 Nov 2001 02:08:13 -0500
Date: Wed, 28 Nov 2001 08:06:58 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: Joachim Backes <backes@rhrk.uni-kl.de>
Cc: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12 ... 2.4.16, /dev/tty
Message-ID: <20011128080658.A1298@wonko.esi.org.pl>
In-Reply-To: <20011127180622.B1087@wonko.esi.org.pl> <XFMail.20011128071832.backes@rhrk.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20011128071832.backes@rhrk.uni-kl.de>
User-Agent: Mutt/1.3.23i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
X-PGP-Key-Fingerprint: B546 B96A 4258 02EF 5CAB  E867 3CDA 420F 7802 6AFE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 28 November 2001, Joachim Backes wrote:
> Hi, Dominik,
> 
[snip no controlling tty problem]  
> >  I believe it's a problem with /bin/login, which has a race condition
> >  preventing it from opening /dev/tty. It is fixed in rawhide, upgrading
> >  util-linux to at least 2.11f-6 solved this for me.
> >  So it's not a kernel issue.
> 
> Thanks, this helped me a lot. Only one issue: after installing rawhide
> vers. 2.11f-16
> of util-linux and not 2.11f-6, my problem disappeared.

Yes, yes. My mistake. I must've been hungry when writing that, because
I simply ate the '1'. :-) Sorry.
 
-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)we.are.one.pl>
