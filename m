Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTKLLEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 06:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTKLLEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 06:04:54 -0500
Received: from calisto.ae.poznan.pl ([150.254.37.3]:2232 "EHLO
	calisto.ae.poznan.pl") by vger.kernel.org with ESMTP
	id S262040AbTKLLEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 06:04:51 -0500
Date: Wed, 12 Nov 2003 12:04:43 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: value 0x37ffffff truncated to 0x37ffffff
In-Reply-To: <Pine.LNX.4.51.0311121029450.30917@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.51.0311121153370.26386@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0311071628470.5963@dns.toxicfilms.tv>
 <200311080142.45003.rob@landley.net> <20031108171858.GA6489@hh.idb.hist.no>
 <Pine.LNX.4.51.0311121029450.30917@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have seen this for along time with debian testing, on intel.
> > I use gcc 3.3.2,
> > binutils: 2.14.90.0.6-5
> Sorry for the delay.
> The same here as for gcc and binutils.
> I will try compiling with gcc 2.95.4.
I did the recompile on 2.6.0test9-bk16 and haven't seen that message now
both with gcc 2.95 and 3.3.2

It is gone.

> Regards,
> Maciej
Maciej

[... this is schizofrenic :-) ...]

