Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTLYGAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 01:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTLYGAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 01:00:22 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:28068 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S263173AbTLYGAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 01:00:21 -0500
From: Eric <eric@cisu.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and VMWare Buslogic Error?
Date: Thu, 25 Dec 2003 00:00:21 -0600
User-Agent: KMail/1.5.94
References: <200312241500.27156.eric@cisu.net> <20031224131509.4460fade.akpm@osdl.org> <200312241615.59018.eric@cisu.net>
In-Reply-To: <200312241615.59018.eric@cisu.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312250000.21980.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 24 December 2003 04:15 pm, Eric wrote:
> On Wednesday 24 December 2003 03:15 pm, Andrew Morton wrote:
> > Eric <eric@cisu.net> wrote:
> > > ERROR: SCSI host `BusLogic' has no error handling
> > > ERROR: This is not a safe way to run your SCSI host
> > > ERROR: The error handling must be added to this driver
> >
> > Please test with
> >
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.
> >0- mm1/broken-out/buslogic-update.patch
> >
> > applied.
>
> 	Yes that gets rid of the message. So far no bad side effects. Ill
> certainly let you know if any come up. In the next few days I will be using
> the VMWare disk image as a base config for a new webserver, so I will be
> working on it. I will let you know If i have any weird scsi problems.
> 	Would you like me to run any sort of tests related to this patch? Im not
> sure how I can help besides just using the patch, but if you have a test
> program I could run, let me know and I'll be happy to give you results from
> it. -------------------------
> Eric Bambach
> Eric at cisu dot net
> -------------------------

-- 
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
