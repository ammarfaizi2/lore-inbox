Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWAVUeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWAVUeC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAVUeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:34:01 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25555 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751321AbWAVUeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:34:00 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug McNaught <doug@mcnaught.org>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
In-Reply-To: <87bqy5m8u3.fsf@asmodeus.mcnaught.org>
References: <20060119030251.GG19398@stusta.de>
	 <200601211826.02159.gene.heskett@verizon.net>
	 <1137886206.11722.1.camel@mindpipe>
	 <200601211853.56339.gene.heskett@verizon.net>
	 <87bqy5m8u3.fsf@asmodeus.mcnaught.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Jan 2006 20:33:57 +0000
Message-Id: <1137962037.19393.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-01-21 at 18:59 -0500, Doug McNaught wrote:
> > OTOH, if this database actually does have a better way, and its mature 
> > and proven, then I see no reason to cripple the database people just to 
> > remove what is viewed as a potentially dangerous path to the media 
> > surface for the unwashed to abuse.
> 
> The database people have a newer and supported way to do that, via the
> O_DIRECT flag to open().  They aren't losing any functionality.

And they'll no doubt update to use it on their cycles of development.
Which for some large vendor systems means five years.

Alan

