Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUALXbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUALXbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:31:47 -0500
Received: from [193.138.115.2] ([193.138.115.2]:63752 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263903AbUALXbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:31:43 -0500
Date: Tue, 13 Jan 2004 00:28:35 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
cc: Pavel Machek <pavel@ucw.cz>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <Pine.LNX.4.44.0401130012100.12912-100000@poirot.grange>
Message-ID: <Pine.LNX.4.56.0401130023120.2130@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0401130012100.12912-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Jan 2004, Guennadi Liakhovetski wrote:

> On Thu, 8 Jan 2004, Pavel Machek wrote:
>
> > In same scenario, TCP detects "congestion" and works mostly okay.
>
> Hm, as long as we are already on this - can you give me a hint / pointer
> how does TCP _detect_ a congestion? Does it adjust packet sizes, some
> other parameters? Just for the curiousity sake.
>
RFC 2581 describes this :
http://www.rfc-editor.org/cgi-bin/rfcdoctype.pl?loc=RFC&letsgo=2581&type=ftp&file_format=txt
3390 updates 2581 :
http://www.rfc-editor.org/cgi-bin/rfcdoctype.pl?loc=RFC&letsgo=3390&type=ftp&file_format=txt


-- Jesper Juhl


