Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWJLAsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWJLAsp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 20:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030699AbWJLAsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 20:48:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33475 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030306AbWJLAso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 20:48:44 -0400
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC
	traffic
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1160610353.7015.8.camel@lade.trondhjem.org>
References: <20061010165621.394703368@quad.kroah.org>
	 <20061010171429.GD6339@kroah.com>
	 <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
	 <1160610353.7015.8.camel@lade.trondhjem.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Oct 2006 02:12:27 +0100
Message-Id: <1160615547.20611.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-11 am 19:45 -0400, ysgrifennodd Trond Myklebust:
> Feel free to tell the board manufacturers that they are idiots, and
> should not design boards that hijack specific ports without providing
> the O/S with any means of detecting this, but in the meantime, it _is_
> the case that they are doing this.

Then their hardware is faulty and should be specifically blacklisted not
make everyone have to deal with silly unmaintainable hacks.

Alan

