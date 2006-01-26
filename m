Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWAZJkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWAZJkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 04:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWAZJkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 04:40:13 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:56770 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932210AbWAZJkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 04:40:11 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 10:38:23 +0100
To: schilling@fokus.fraunhofer.de, grundig@teleline.es
Cc: schilling@fokus.fraunhofer.de, rlrevell@joe-job.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, axboe@suse.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8988F.nailDTH21LS0G@burner>
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com>
 <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
 <20060125144543.GY4212@suse.de>
 <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es>
In-Reply-To: <20060125181847.b8ca4ceb.grundig@teleline.es>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<grundig@teleline.es> wrote:

> El Wed, 25 Jan 2006 18:03:18 +0100,
> Joerg Schilling <schilling@fokus.fraunhofer.de> escribió:
>
> > Guess why cdrecord -scanbus is needed.
> > 
> > It serves the need of GUI programs for cdrercord and allows them to retrieve 
> > and list possible drives of interest in a platform independent way.
>
> But this is not neccesary at all, since linux platform already provides ways to
> retrieve and list possible drives....

Interesting: You claim that the Linux platform provides ways to retrieve 
the needed information on FreeBSD, MS-WIN, ....?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
