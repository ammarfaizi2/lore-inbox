Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbTLHNGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265388AbTLHNGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:06:09 -0500
Received: from intra.cyclades.com ([64.186.161.6]:50831 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265387AbTLHNFY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:05:24 -0500
Date: Mon, 8 Dec 2003 10:58:58 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: "Michael D. Harnois" <mharnois@cpinternet.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: XFS merged in 2.4
In-Reply-To: <1070887696.16336.16.camel@mharnois.mdharnois.net>
Message-ID: <Pine.LNX.4.44.0312081058330.1148-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, Michael D. Harnois wrote:

> It seems to have been incompletely merged in patch-2.4.23-bk6, where
> make dies with
> 
> /usr/bin/make -C xfs fastdep
> make: *** xfs: No such file or directory.  Stop.

Right. The current BK has the fs/xfs merge and should work. 

