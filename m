Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262364AbSI3QTH>; Mon, 30 Sep 2002 12:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSI3QTE>; Mon, 30 Sep 2002 12:19:04 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:55791 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262364AbSI3QSi>; Mon, 30 Sep 2002 12:18:38 -0400
Subject: Re: 2.5 Kernel Problem Reports as of 27 Sep
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: tmolina@cox.net, linux-kernel@vger.kernel.org
In-Reply-To: <200209300010.CAA02879@harpo.it.uu.se>
References: <200209300010.CAA02879@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 17:29:42 +0100
Message-Id: <1033403382.16918.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 01:10, Mikael Pettersson wrote:
> On Fri, 27 Sep 2002 19:54:16 -0500 (CDT), Thomas Molina wrote:
> >------------------------------------------------------------------------
> >  24. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2
> >   IDE problems on prePCI                 open               23 Sep 2002
> >
> >This was reported by Mikael Pettersson <mikpe@csd.uu.se>, but never 
> >responded to, and never followed up.  Should this be kept open?
> 
> The hang in INIT with 2.5.38 is gone with 2.5.39, but the instant
> reboot when I pass the "ide0=qd65xx" kernel option is still there.

This seems to be working ok on the 2.4.20pre8-ac IDE branch.

