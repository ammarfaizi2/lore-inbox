Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271737AbTHMKVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 06:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271738AbTHMKVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 06:21:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24259 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271737AbTHMKU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 06:20:59 -0400
Date: Wed, 13 Aug 2003 03:14:32 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: rddunlap@osdl.org, davej@redhat.com, greg@kroah.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-Id: <20030813031432.22b6a0d6.davem@redhat.com>
In-Reply-To: <3F39AFDF.1020905@pobox.com>
References: <20030812020226.GA4688@zip.com.au>
	<1060654733.684.267.camel@localhost>
	<20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk>
	<20030812053826.GA1488@kroah.com>
	<20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk>
	<20030812180158.GA1416@kroah.com>
	<3F397FFB.9090601@pobox.com>
	<20030812171407.09f31455.rddunlap@osdl.org>
	<3F3986ED.1050206@pobox.com>
	<20030812173742.6e17f7d7.rddunlap@osdl.org>
	<20030813004941.GD2184@redhat.com>
	<32835.4.4.25.4.1060743746.squirrel@www.osdl.org>
	<3F39AFDF.1020905@pobox.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey guys, define a set of macros to make it more readable.
This would keep the number of lines down and also make
the C99 folks happy.

I think there is real value in moving over the C99 completely.
And we can do this without the source bloat effect.
