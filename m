Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266639AbTGFHqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbTGFHqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 03:46:25 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:5381 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S266631AbTGFHqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 03:46:24 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Chris Mason <mason@suse.com>
Subject: Re: Status of the IO scheduler fixes for 2.4
Date: Sun, 6 Jul 2003 09:58:36 +0200
User-Agent: KMail/1.5.2
Cc: lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>,
       Nick Piggin <piggin@cyberone.com.au>
References: <Pine.LNX.4.55L.0307021923260.12077@freak.distro.conectiva> <Pine.LNX.4.55L.0307041639020.7389@freak.distro.conectiva> <1057354654.20903.1280.camel@tiny.suse.com>
In-Reply-To: <1057354654.20903.1280.camel@tiny.suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307060958.36642.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 July 2003 23:37, Chris Mason wrote:

Hi Chris,

> > If the IO fairness still doesnt
> > get somewhat better for general use (well get isolated user reports and
> > benchmarks for both the two patches), then I might consider the q->full
> > patch (it has throughtput drawbacks and I prefer avoiding a tunable
> > there).
now there is io-stalls-10 in .22-pre3 (lowlat elev. + fixpausing). Could you 
please send "q->full patch" as ontop of -pre3? :-)

Thank you.

ciao, Marc

