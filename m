Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbTLHNiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbTLHNiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:38:17 -0500
Received: from intra.cyclades.com ([64.186.161.6]:1432 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265399AbTLHNiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:38:15 -0500
Date: Mon, 8 Dec 2003 11:21:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mikael Johansson <mpjohans@pcu.helsinki.fi>,
       <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <riel@redhat.com>, <knobi@knobisoft.de>, Jens Axboe <axboe@suse.de>,
       <mason@suse.com>
Subject: Re: RAID-0 read perf. decrease after 2.4.20
In-Reply-To: <200312081411.04057.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.44.0312081121310.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, Marc-Christian Petersen wrote:

> On Monday 08 December 2003 13:47, Marcelo Tosatti wrote:
> 
> Hi Marcelo,
> 
> > 2.4.20-aa included rmap and some VM modifications most notably
> > "drop_behind()" logic which I believe should be the reason for the huge
> > read speedups. Can you please try it? Against 2.4.23.
> 
> -aa tree never had -rmap :)

-ac I mean, sorry. 

