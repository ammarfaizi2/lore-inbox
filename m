Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbUJaEp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbUJaEp5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 00:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUJaEp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 00:45:57 -0400
Received: from pop-7.dnv.wideopenwest.com ([64.233.207.25]:60832 "EHLO
	pop-7.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S261499AbUJaEpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 00:45:50 -0400
Date: Sun, 31 Oct 2004 00:45:49 -0400
From: Paul <set@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: code bloat [was Re: Semaphore assembly-code bug]
Message-ID: <20041031044549.GC6507@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org> <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua> <1099178405.1441.7.camel@krustophenia.net> <1099176751.25194.12.camel@localhost.localdomain> <Pine.LNX.4.58.0410310155080.11293@ppg_penguin.kenmoffat.uklinux.net> <slrn-0.9.7.4-21646-32676-200410311340-tc@hexane.ssi.swin.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrn-0.9.7.4-21646-32676-200410311340-tc@hexane.ssi.swin.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors <tconnors+linuxkernel1099190446@astro.swin.edu.au>, on Sun Oct 31, 2004 [01:42:34 PM] said:
> Ken Moffat <ken@kenmoffat.uklinux.net> said on Sun, 31 Oct 2004 01:09:54 +0000 (GMT):
> > and the time to load it is irrelevant.  Since then I've had an anecdotal
> > report that -Os is known to cause problems with gnome.  I s'pose people
> > will say it serves me right for doing my initial testing on ppc which
> > didn't have this problem ;)  The point is that -Os is *much* less tested
> > than -O2 at the moment.
> 
> Because people suck, and don't use it and hence test it.
> 
> Ie, test it!
> 
> I can't, because I prefer to stay away from gnome instead.
> 

	Hi;

	Ive been using -Os as my default compile flag under
Gentoo for probably over 2 years now. Havent noted any real
problems, and thats nearly 3gig of compressed source code
compiled on what is just my current system image.
	(Well, I might suck a little because I havent done any
benchmarks or comparisons as to the actual benifits of doing
so. Also, I use fvwm;)

Paul
set@pobox.com

> -- 
> TimC -- http://astronomy.swin.edu.au/staff/tconnors/
