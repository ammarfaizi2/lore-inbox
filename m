Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWBCOFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWBCOFv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWBCOFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:05:51 -0500
Received: from soundwarez.org ([217.160.171.123]:49801 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1750827AbWBCOFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:05:50 -0500
Date: Fri, 3 Feb 2006 15:05:35 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, rlrevell@joe-job.com,
       jim@why.dont.jablowme.net, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203140535.GA17327@vrfy.org>
References: <43DF6812.nail3B44TLQOP@burner> <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <1138915551.15691.123.camel@mindpipe> <43E35AC8.nail5CAD55WJ3@burner> <Pine.LNX.4.61.0602031448270.7991@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602031448270.7991@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 02:51:10PM +0100, Jan Engelhardt wrote:
> >
> >The main point is not to poll to frequent (Solaris does once everz 3 seconds)
> >and to use SCSI commands only that to not interrupt or disturb CD/DVD-writing.
> >
> 
> I do not have any problems with resmgr/hal ATM (SUSE Linux 10.0). Although 
> hal [seems to] probes more often than once/3sec,

It polls every 2 seconds.

> it did not interrupt any 
> of my cd writing processes. Maybe that's already a feature of cdrecord*, I 
> don't know.

I don't know of any problem in that area and almost every modern Linux
desktop has HAL running these days, so I'm sure somebody would have
complained.

Kay
