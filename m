Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUBXBdq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbUBXBae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:30:34 -0500
Received: from dhcp-48-179.Connectathon.ORG ([130.128.48.179]:32006 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S262122AbUBXB3N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:29:13 -0500
Subject: Re: Fw: Client looses NFS handle (kernel 2.6.3)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Willy Weisz <weisz@vcpc.univie.ac.at>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040223142811.I22989@build.pdx.osdl.net>
References: <20040221214345.6533eb68.akpm@osdl.org>
	 <1077444724.2944.10.camel@nidelv.trondhjem.org>
	 <20040223142811.I22989@build.pdx.osdl.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1077586057.2856.48.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 23 Feb 2004 17:27:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 23/02/2004 klokka 14:28, skreiv Chris Wright:
> > 
> > http://www.fys.uio.no/~trondmy/src/Linux-2.6.x/2.6.3/linux-2.6.3-08-reconnect.dif
> 
> Looks nice.  Will this go upstream, or is there still other issue?

No known issues, so I expect it to go upstream RSN. I just thought it
would be convenient to make use of the fact that the Connectathon
inter-vendor testfest is on right now to give it some extra milage first
;-).

Cheers,
  Trond
