Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266235AbUARHFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 02:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUARHFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 02:05:40 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:28810
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S266235AbUARHFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 02:05:35 -0500
Subject: Re: [RFC] kill sleep_on
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1074409074.1569.12.camel@nidelv.trondhjem.org>
References: <40098251.2040009@colorfullife.com>
	 <1074367701.9965.2.camel@imladris.demon.co.uk>
	 <20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
	 <1074383111.9965.4.camel@imladris.demon.co.uk>
	 <20040117224139.5585fb9c.akpm@osdl.org>
	 <1074409074.1569.12.camel@nidelv.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074409534.1569.17.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 18 Jan 2004 02:05:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 18/01/2004 klokka 01:57, skreiv Trond Myklebust:
> Chuck is therefore working on a set of patches to add an
> "iostat"-like tool to the NFS client.

Sorry - that was poorly formulated:

Chuck has been working on this issue on his _own_ initiative. I'm now
convinced that he is right to be doing so, and will be pushing to get
his patches into the kernel.

Cheers,
  Trond
