Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVLDUIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVLDUIc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 15:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVLDUIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 15:08:32 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:4531 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932331AbVLDUIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 15:08:31 -0500
Date: Sun, 4 Dec 2005 12:08:20 -0800
From: Paul Jackson <pj@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-Id: <20051204120820.74ed2878.pj@sgi.com>
In-Reply-To: <1133714480.5188.62.camel@laptopd505.fenrus.org>
References: <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	<20051203201945.GA4182@kroah.com>
	<f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
	<20051203211209.GA4937@kroah.com>
	<f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
	<1133645895.22170.33.camel@laptopd505.fenrus.org>
	<f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>
	<1133682973.5188.3.camel@laptopd505.fenrus.org>
	<f0cc38560512040657i58cc08efqa8596c357fcea82e@mail.gmail.com>
	<1133709038.5188.49.camel@laptopd505.fenrus.org>
	<20051204161157.GB17846@merlin.emma.line.org>
	<1133714480.5188.62.camel@laptopd505.fenrus.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan, responding to Matthias
> > SUSE end-user distros (SUSE LINUX <version>) are released every 6 months
> > or so, and are supported for 24 months. Their "enterprise server" is
> > supported for 60 months though, SLES 9 forked off 9.1.
> 
> sure.. but they don't add new hw support really, and I'd not be
> surprised if they rebase to a newer upstream kernel after a while.

They will start a new enterprise release, off a new base, every so
often, and call the next one SLES 10.  But SLES 9 will continue to be
supported, off its current kernel.org base, for an extended period of
time.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
